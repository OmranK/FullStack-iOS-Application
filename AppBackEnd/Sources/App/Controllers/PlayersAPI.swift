//
//  File.swift
//  
//
//  Created by Omran Khoja on 12/8/21.
//
import Vapor
import Fluent

struct PlayersAPI: RouteCollection {
    
    private let playerID = "playerID"
    private let imageFolder = "Images/PlayerPictures/"
    
    func boot(routes: RoutesBuilder) throws {
        
        // MARK: - Set parent path for API + subpaths
        let playersRoute = routes.grouped("api", "players")
        let playerID: PathComponent = ":playerID"
        let sortedPlayers: PathComponent = "sorted"
        let searchMatch: PathComponent = "search"
        let firstMatch: PathComponent = "first"
        let currentTeam: PathComponent = "team"
        let playerPhoto: PathComponent = "playerPhoto"
        
        // MARK: - Routes
        playersRoute.post(use: createHandler)
        playersRoute.get(use: getAllHandler)
        playersRoute.get(playerID,  use: getHandler)
        playersRoute.put(playerID,  use: updateHandler)
        playersRoute.delete(playerID,  use: deleteHandler)
        playersRoute.get(searchMatch, use: searchHandler)
        playersRoute.get(firstMatch, use: searchHandler)
        playersRoute.get(sortedPlayers, use: sortedHandler)
        playersRoute.get(playerID, currentTeam, use: getTeamHandler)
        
        playersRoute.on(.GET, playerID, playerPhoto, body: .collect(maxSize: "10mb"), use: getPlayerPictureHandler)
    }
    
    // MARK: - CRUD Operations
    
    func createHandler(_ req: Request) throws -> EventLoopFuture<Player> {
        let playerData = try req.content.decode(CreatePlayerData.self)
        
        let player = Player(
            firstName: playerData.firstName,
            lastName: playerData.lastName,
            playerNumber: playerData.playerNumber,
            height: playerData.height,
            position: playerData.position,
            teamID: playerData.teamID)
        
        return player.save(on: req.db).map {
            player
        }
    }
    
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Player]> {
        Player.query(on: req.db).all()
    }
    
    func getHandler(_ req: Request) -> EventLoopFuture<Player> {
        Player.find(req.parameters.get(playerID), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Player> {
        let updatedPlayerData = try req.content.decode(CreatePlayerData.self)
        
        return Player.find(req.parameters.get(playerID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { player in
                player.firstName = updatedPlayerData.firstName
                player.lastName = updatedPlayerData.lastName
                player.playerNumber = updatedPlayerData.playerNumber
                player.height = updatedPlayerData.height
                player.position = updatedPlayerData.position
                player.$currentTeam.id = updatedPlayerData.teamID
                
                return player.save(on: req.db).map {
                    player
                }
            }
    }
    
    func deleteHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Player.find(req.parameters.get(playerID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { player in
                player.delete(on: req.db)
                    .transform(to: .noContent)
            }
    }
    
    func searchHandler(_ req: Request) throws -> EventLoopFuture<[Player]> {
        guard let searchTerm = req.query[String.self, at: "term"] else {
            throw Abort(.badRequest)
        }
        return Player.query(on: req.db).group(.or) { or in
            or.filter(\.$firstName == searchTerm)
            or.filter(\.$lastName == searchTerm)
        }.all()
    }
    
    func sortedHandler(_ req: Request) -> EventLoopFuture<[Player]> {
        return Player.query(on: req.db)
            .sort(\.$playerNumber, .ascending).all()
    }
    
    func getTeamHandler(_ req: Request) -> EventLoopFuture<Team> {
        Player.find(req.parameters.get(playerID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { player in
                player.$currentTeam.get(on: req.db)
            }
    }
    
    
    func getPlayerPictureHandler(_ req: Request) -> EventLoopFuture<Response> {
        Player.find(req.parameters.get(playerID), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing { player in
                guard let filename = player.playerPicture else {
                    throw Abort(.notFound)
                }
                let path = req.application.directory.workingDirectory + imageFolder + filename
                return req.fileio.streamFile(at: path, mediaType: .jpeg)
            }
    }
}

// MARK: - Domain Transfer Objects (DTOs)
// Because Acronym has a user property, the JSON must match this. The property wrapper allows you to only send an id for user, but it’s still complex to create. To solve this, you use a Domain Transfer Object or DTO. A DTO is a type that represents what a client should send or receive. Your route handler then accepts a DTO and converts it into something your code can use. At the bottom of AcronymsController.swift, add the following code:

struct CreatePlayerData: Content {
    let firstName: String
    let lastName: String
    let playerNumber: Int
    let height: Int
    let position: Player.PlayerPosition
    var teamID: UUID
}
