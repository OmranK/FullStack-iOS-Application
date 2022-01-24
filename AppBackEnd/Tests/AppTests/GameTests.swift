//
//  File.swift
//  
//
//  Created by Omran Khoja on 12/9/21.
//

@testable import App
import XCTVapor

final class GameTests: XCTestCase {
    
    // MARK: - Team Tests Default Environment Variables
    let team = Team(name: "Haiti", wins: 8, losses: 8)
    let gameDate = Date("2022-06-06T23:30:00Z")
    let gamesURI = "/api/games/"
    var app: Application!
    
    // MARK: - Test Lifecycle Functions (Runs before and after each test)
    override func setUpWithError() throws {
        app = try Application.testable()
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }
    
    // MARK: - Test Create Route
    func testGameCanBeSavedWithAPI() throws {
        let team = try Team.create(on: app.db)
        let team2 = try Team.create(name: "USA", wins: 9, losses: 7, on: app.db)
        let gameData = CreateGameData(date: gameDate, location: "Crypto.com Arena", homeTeamID: team.id!, awayTeamID: team2.id!)

        try app.test(.POST, gamesURI, beforeRequest: { req in
            try req.content.encode(gameData)
        }, afterResponse: { response in
            let returnedGame = try response.content.decode(Game.self)
            XCTAssertEqual(returnedGame.date, gameData.date)
            XCTAssertEqual(returnedGame.location, gameData.location)
            XCTAssertEqual(returnedGame.$homeTeam.id, gameData.homeTeamID)
            XCTAssertEqual(returnedGame.$awayTeam.id, gameData.awayTeamID)
            XCTAssertNotNil(returnedGame.id)

            try app.test(.GET, gamesURI, afterResponse: { secondResponse in
                let games = try secondResponse.content.decode([Game].self)
                XCTAssertEqual(games.count, 1)
                XCTAssertEqual(games[0].date, gameData.date)
                XCTAssertEqual(games[0].location, gameData.location)
                XCTAssertEqual(games[0].$homeTeam.id, gameData.homeTeamID)
                XCTAssertEqual(games[0].$awayTeam.id, gameData.awayTeamID)
                XCTAssertNotNil(games[0].id)
            })
        })
    }
    
    // MARK: - Test Retreive Routes
    func testGamesCanBeRetrievedFromAPI() throws {
        let team = try Team.create(on: app.db)
        let team2 = try Team.create(name: "USA", wins: 9, losses: 7, on: app.db)
        let team3 = try Team.create(name: "Haiti", wins: 8, losses: 8, on: app.db)
        
        let game1 = try Game.create(homeTeamID: team.id!, awayTeamID: team2.id!, on: app.db)
        let _ = try Game.create(homeTeamID: team.id!, awayTeamID: team3.id!, on: app.db)

        try app.test(.GET, gamesURI, afterResponse: { response in
            XCTAssertEqual(response.status, .ok)

            let games = try response.content.decode([Game].self)
            XCTAssertEqual(games.count, 2)
            XCTAssertEqual(games[0].date, game1.date)
            XCTAssertEqual(games[0].location, game1.location)
            XCTAssertEqual(games[0].$homeTeam.id, game1.$homeTeam.id)
            XCTAssertEqual(games[0].$awayTeam.id, game1.$awayTeam.id)
        })
    }

    func testSingleGameCanBeRetrievedFromAPI() throws {
        let team = try Team.create(on: app.db)
        let team2 = try Team.create(name: "USA", wins: 9, losses: 7, on: app.db)
        
        let game = try Game.create(homeTeamID: team.id!, awayTeamID: team2.id!, on: app.db)

        try app.test(.GET, "\(gamesURI)\(game.id!)", afterResponse: { response in
            let receivedGame = try response.content.decode(Game.self)

            XCTAssertEqual(receivedGame.date, game.date)
            XCTAssertEqual(receivedGame.location, game.location)
            XCTAssertEqual(receivedGame.$homeTeam.id, game.$homeTeam.id)
            XCTAssertEqual(receivedGame.$awayTeam.id, game.$awayTeam.id)
        })
    }

    // MARK: - Test Delete Route
    func testGameCanBeDeletedFromAPI() throws {
        let team = try Team.create(on: app.db)
        let team2 = try Team.create(name: "USA", wins: 9, losses: 7, on: app.db)
        let team3 = try Team.create(name: "Haiti", wins: 8, losses: 8, on: app.db)
        
        let game1 = try Game.create(homeTeamID: team.id!, awayTeamID: team2.id!, on: app.db)
        let game2 = try Game.create(homeTeamID: team.id!, awayTeamID: team3.id!, on: app.db)
        
        try app.test(.DELETE, "\(gamesURI)\(game1.id!)", afterResponse: { response in

            XCTAssertEqual(response.status, .noContent)

            try app.test(.GET, gamesURI, afterResponse: { secondResponse in
                let games = try secondResponse.content.decode([Game].self)
                XCTAssertEqual(games.count, 1)
                XCTAssertEqual(games[0].date, game2.date)
                XCTAssertEqual(games[0].location, game2.location)
                XCTAssertEqual(games[0].$homeTeam.id, game2.$homeTeam.id)
                XCTAssertEqual(games[0].$awayTeam.id, game2.$awayTeam.id)
    
            })
        })
    }

    // MARK: - Test Update Route
    func testGameUpdatesCorrectly() throws {
        let team = try Team.create(name: "USA", wins: 9, losses: 7, on: app.db)
        let team2 = try Team.create(name: "Haiti", wins: 8, losses: 8, on: app.db)
        let game1 = try Game.create(homeTeamID: team.id!, awayTeamID: team2.id!, on: app.db)
        let gameData = CreateGameData(date: gameDate, location: "Crypto.com Arena", homeTeamID: team.id!, awayTeamID: team2.id!)

        try app.test(.PUT, "\(gamesURI)\(game1.id!)", beforeRequest: { req in
            try req.content.encode(gameData)
        }, afterResponse: { response in
            let returnedGame = try response.content.decode(Game.self)
            XCTAssertEqual(returnedGame.date, gameData.date)
            XCTAssertEqual(returnedGame.location, gameData.location)
            XCTAssertEqual(returnedGame.$homeTeam.id, gameData.homeTeamID)
            XCTAssertEqual(returnedGame.$awayTeam.id, gameData.awayTeamID)
            XCTAssertNotNil(returnedGame.id)

            try app.test(.GET, gamesURI, afterResponse: { secondResponse in
                let games = try secondResponse.content.decode([Game].self)
                XCTAssertEqual(games.count, 1)
                XCTAssertEqual(games[0].date, gameData.date)
                XCTAssertEqual(games[0].location, gameData.location)
                XCTAssertEqual(games[0].$homeTeam.id, gameData.homeTeamID)
                XCTAssertEqual(games[0].$awayTeam.id, gameData.awayTeamID)
                XCTAssertNotNil(games[0].id)
            })
        })
    }

    // MARK: - Test Get Teams Route

    func testGameTeamsCanBeRetreivedFromAPI() throws {
        let team = try Team.create(name: "USA", wins: 9, losses: 7, on: app.db)
        let team2 = try Team.create(name: "Haiti", wins: 8, losses: 8, on: app.db)
        let game = try Game.create(homeTeamID: team.id!, awayTeamID: team2.id!, on: app.db)

        try app.test(.GET, "\(gamesURI)\(game.id!)/teams", afterResponse: { response in
            let teams = try response.content.decode([Team].self)
            XCTAssertEqual(teams.count, 2)
//            XCTAssertEqual(teams[0].id, team.id!)
//            XCTAssertEqual(teams[1].id, team2.id!)
        })
    }
}
