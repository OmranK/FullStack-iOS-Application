//
//  File.swift
//  
//
//  Created by Omran Khoja on 12/9/21.
//

import Vapor
import Fluent

final class GamesAPI: RouteCollection {

    private let gameID = "gameID"
    private let teamID = "teamID"
    
    func boot(routes: RoutesBuilder) throws {
        
        //Set the main path for the whole API + subpaths
        let gamesRoute = routes.grouped("api", "games")
        let game: PathComponent = ":gameID"
        let teams: PathComponent = "teams"
        let sorted: PathComponent = "sorted"
        
        // Routes
        gamesRoute.post(use: createHandler)
        gamesRoute.get(use: getAllHandler)
        gamesRoute.get(game,  use: getHandler)
        gamesRoute.put(game,  use: updateHandler)
        gamesRoute.delete(game,  use: deleteHandler)
        gamesRoute.get(game, teams, use: getTeamsHandler)
        gamesRoute.get(game, sorted, use: sortedHandler)
        
    }
    
    // CRUD Operations
    func createHandler(_ req: Request) throws -> EventLoopFuture<Game> {
        let gameData = try req.content.decode(CreateGameData.self)
        
        let game = Game(
            date: gameData.date,
            location: gameData.location,
            homeTeamID: gameData.homeTeamID,
            awayTeamID: gameData.awayTeamID)
        
        return game.save(on: req.db).map {
            game
        }
    }
    
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Game]> {
        Game.query(on: req.db).all()
    }
    
    func getHandler(_ req: Request) -> EventLoopFuture<Game> {
        Game.find(req.parameters.get(gameID), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Game> {
        let updatedGameData = try req.content.decode(CreateGameData.self)
        
        return Game.find(req.parameters.get(gameID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { game in
                game.date = updatedGameData.date
                game.location = updatedGameData.location
                game.$homeTeam.id = updatedGameData.homeTeamID
                game.$awayTeam.id = updatedGameData.awayTeamID
               
                return game.save(on: req.db).map {
                    game
                }
            }
    }
    
    func deleteHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Game.find(req.parameters.get(gameID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { game in
                game.delete(on: req.db)
                    .transform(to: .noContent)
            }
    }
    
    func getTeamsHandler(_ req: Request) -> EventLoopFuture<[Team]> {
        Game.find(req.parameters.get(gameID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { game in
                game.$homeTeam.get(on: req.db).and(game.$awayTeam.get(on: req.db))
            }.map { (home, away) in
                return [home, away]
            }
    }
    
    func sortedHandler(_ req: Request) -> EventLoopFuture<[Game]> {
        return Game.query(on: req.db)
            .sort(\.$date, .ascending).all()
    }
    
}

struct CreateGameData: Content {
    let date: Date
    let location: String
    var homeTeamID: UUID
    var awayTeamID: UUID
}

struct GameData: Content {
    let date: Date
    let location: String
    var homeTeamID: UUID
    var awayTeamID: UUID
    
}
