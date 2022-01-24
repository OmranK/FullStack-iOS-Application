//
//  File.swift
//  
//
//  Created by Omran Khoja on 12/8/21.
//

import Vapor
import Fluent

struct TeamsAPI: RouteCollection {

    private let teamID = "teamID"
    private let imageFolder = "Images/TeamPictures/"
    
    func boot(routes: RoutesBuilder) throws {
        
        //Set the main path for the whole API + subpaths
        let teamsRoute = routes.grouped("api", "teams")
        let team: PathComponent = ":teamID"
        let searchMatch: PathComponent = "search"
        let roster: PathComponent = "players"
        let scheduledGames: PathComponent = "games"
        let teamPhoto: PathComponent = "teamPhoto"
        
        // Routes
        teamsRoute.post(use: createHandler)
        teamsRoute.get(use: getAllHandler)
        teamsRoute.get(team,  use: getHandler)
        teamsRoute.put(team,  use: updateHandler)
        teamsRoute.delete(team,  use: deleteHandler)
        teamsRoute.get(searchMatch, use: searchHandler)
        teamsRoute.get(team, roster, use: getPlayersHandler)
        teamsRoute.get(team, scheduledGames, use: getGamesHandler)
        teamsRoute.on(.POST, team, teamPhoto, body: .collect(maxSize: "10mb"), use: createTeamPictureHandler)
        
        teamsRoute.on(.GET, team, teamPhoto, body: .collect(maxSize: "10mb"), use: getTeamPictureHandler)
    }
    
    
    // CRUD Operations
    func createHandler(_ req: Request) throws -> EventLoopFuture<Team> {
        let team = try req.content.decode(Team.self)
        return team.save(on: req.db).map {
            team
        }
    }
    
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Team]> {
        Team.query(on: req.db).all()
    }
    
    func getHandler(_ req: Request) -> EventLoopFuture<Team> {
        Team.find(req.parameters.get(teamID), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Team> {
        let updatedTeam = try req.content.decode(Team.self)
        
        return Team.find(req.parameters.get(teamID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { team in
                team.name = updatedTeam.name
                team.wins = updatedTeam.wins
                team.losses = updatedTeam.losses
                
                return team.save(on: req.db).map {
                    team
                }
            }
    }
    
    func deleteHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Team.find(req.parameters.get(teamID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { team in
                team.delete(on: req.db)
                    .transform(to: .noContent)
            }
    }
    
    func searchHandler(_ req: Request) throws -> EventLoopFuture<[Team]> {
        guard let searchTerm = req.query[String.self, at: "term"] else {
            throw Abort(.badRequest)
        }
        return Team.query(on: req.db).filter(\.$name == searchTerm).all()
    }
    
    
    func getPlayersHandler(_ req: Request) -> EventLoopFuture<[Player]> {
        Team.find(req.parameters.get(teamID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { team in
                team.$players.get(on: req.db)
            }
    }
    
    func getGamesHandler(_ req: Request) -> EventLoopFuture<[Game]> {
        Team.find(req.parameters.get(teamID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { team in
                team.$homeGames.get(on: req.db).and(team.$awayGames.get(on: req.db))
            }.map { homeTeam, awayTeam in
                return [homeTeam, awayTeam].reduce([], +)
            }
    }
    
    func createTeamPictureHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let data = try req.content.decode(ImageUploadData.self)
        return Team.find(req.parameters.get(teamID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { team in
                
                let teamID: UUID
                do {
                    teamID = try team.requireID()
                } catch {
                    return req.eventLoop.future(error: error)
                }
                
                let name = "\(teamID)-\(UUID()).jpg"
                let path = req.application.directory.workingDirectory + imageFolder + name
                
                return req.fileio
                    .writeFile(.init(data: data.picture), at: path)
                    .flatMap {
                        team.teamPicture = name
                        return team.save(on: req.db)
                            .transform(to: .noContent)
//                        return team.save(on: req.db).map {
//                            team
//                        }
                    }
            }
    }
    
    func getTeamPictureHandler(_ req: Request) -> EventLoopFuture<Response> {
        Team.find(req.parameters.get(teamID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing { team in
                guard let filename = team.teamPicture else {
                    throw Abort(.notFound)
                }
                
                let path = req.application.directory.workingDirectory + imageFolder + filename
                return req.fileio.streamFile(at: path, mediaType: .png)
            }
    }
    
    
}

struct ImageUploadData: Content {
    var picture: Data
}
