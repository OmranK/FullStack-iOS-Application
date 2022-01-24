//
//  File.swift
//  
//
//  Created by Omran Khoja on 12/9/21.
//

@testable import App
import XCTVapor

final class PlayerTests: XCTestCase {
    
    // MARK: - Player Tests Default Environment Variables
    let teamsURI = "/api/teams/"
    let playersURI = "/api/players/"
    var app: Application!
    
    // MARK: - Test Lifecycle Functions (Runs before and after each test)
    override func setUpWithError() throws {
        app = try Application.testable()
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }
    
    // MARK: - Test Create Route
    func testPlayerCanBeSavedWithAPI() throws {
        
        let team = try Team.create(on: app.db)
        let playerData =  CreatePlayerData(firstName: "Lebron", lastName: "James", playerNumber: 10, height: 200, position: .blocker, teamID: team.id!)
        
        try app.test(.POST, playersURI, beforeRequest: { req in
            try req.content.encode(playerData)
        }, afterResponse: { response in
            
            let receivedPlayer = try response.content.decode(Player.self)
            
            XCTAssertEqual(receivedPlayer.firstName, playerData.firstName)
            XCTAssertEqual(receivedPlayer.lastName, playerData.lastName)
            XCTAssertEqual(receivedPlayer.playerNumber, playerData.playerNumber)
            XCTAssertEqual(receivedPlayer.height, playerData.height)
            XCTAssertEqual(receivedPlayer.position, playerData.position)
            XCTAssertEqual(receivedPlayer.$currentTeam.id, playerData.teamID)
            XCTAssertNotNil(receivedPlayer.id)
            
            try app.test(.GET, playersURI, afterResponse: { secondResponse in
                let players = try secondResponse.content.decode([Player].self)
                XCTAssertEqual(players.count, 1)
                XCTAssertEqual(players[0].firstName, playerData.firstName)
                XCTAssertEqual(players[0].lastName, playerData.lastName)
                XCTAssertEqual(players[0].playerNumber, playerData.playerNumber)
                XCTAssertEqual(players[0].height, playerData.height)
                XCTAssertEqual(players[0].position, playerData.position)
                XCTAssertEqual(players[0].$currentTeam.id, playerData.teamID)
                XCTAssertNotNil(players[0])
            })
        })
    }
    
    
    // MARK: - Test Retreive Route
    func testPlayerCanBeRetreivedWithAPI() throws {
        let team = try Team.create(on: app.db)
        let player =  try Player.create(firstName: "Lebron", lastName: "James", playerNumber: 10, height: 200, position: .blocker, teamID: team.id!, on: app.db)
        let _ = try Player.create(teamID: team.id!, on: app.db)
        
        
        try app.test(.GET, playersURI, afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
            
            let players = try response.content.decode([Player].self)
            XCTAssertEqual(players.count, 2)
            XCTAssertEqual(players[0].firstName, player.firstName)
            XCTAssertEqual(players[0].lastName, player.lastName)
            XCTAssertEqual(players[0].playerNumber, player.playerNumber)
            XCTAssertEqual(players[0].height, player.height)
            XCTAssertEqual(players[0].position, player.position)
            XCTAssertEqual(players[0].$currentTeam.id, player.$currentTeam.id)
            XCTAssertEqual(players[0].id, player.id)
        })
    }
    
    
    func testSinglePlayerCanBeRetrievedFromAPI() throws {
        
        let team = try Team.create(on: app.db)
        let player =  try Player.create(firstName: "Lebron", lastName: "James", playerNumber: 10, height: 200, position: .blocker, teamID: team.id!, on: app.db)
        let _ = try Player.create(teamID: team.id!, on: app.db)
        
        try app.test(.GET, "\(playersURI)\(player.id!)", afterResponse: { response in
            let retreivedPlayer = try response.content.decode(Player.self)
            
            XCTAssertEqual(retreivedPlayer.firstName, player.firstName)
            XCTAssertEqual(retreivedPlayer.lastName, player.lastName)
            XCTAssertEqual(retreivedPlayer.playerNumber, player.playerNumber)
            XCTAssertEqual(retreivedPlayer.height, player.height)
            XCTAssertEqual(retreivedPlayer.position, player.position)
            XCTAssertEqual(retreivedPlayer.$currentTeam.id, player.$currentTeam.id)
            XCTAssertEqual(retreivedPlayer.id, player.id)
        })
    }
    
    
    // MARK: - Test Delete Route
    func testPlayerCanBeDeletedFromAPI() throws {
        let team = try Team.create(on: app.db)
        let player =  try Player.create(firstName: "Lebron", lastName: "James", playerNumber: 10, height: 200, position: .blocker, teamID: team.id!, on: app.db)
        let player2 = try Player.create(teamID: team.id!, on: app.db)
        
        try app.test(.DELETE, "\(playersURI)\(player.id!)", afterResponse: { response in
            
            XCTAssertEqual(response.status, .noContent)
            
            try app.test(.GET, playersURI, afterResponse: { secondResponse in
                
                let players = try secondResponse.content.decode([Player].self)
                XCTAssertEqual(players.count, 1)
                XCTAssertEqual(players[0].firstName, player2.firstName)
                XCTAssertEqual(players[0].lastName, player2.lastName)
                XCTAssertEqual(players[0].playerNumber, player2.playerNumber)
                XCTAssertEqual(players[0].height, player2.height)
                XCTAssertEqual(players[0].position, player2.position)
                XCTAssertEqual(players[0].$currentTeam.id, player2.$currentTeam.id)
                XCTAssertEqual(players[0].id, player2.id)
            })
            
        })
    }
    
    // MARK: - Test Update Route
    func testPlayerUpdatesCorrectly() throws {
        let team = try Team.create(on: app.db)
        let playerData =  CreatePlayerData(firstName: "Steph", lastName: "Curry", playerNumber: 08, height: 180, position: .participer, teamID: team.id!)
        let player2 = try Player.create(teamID: team.id!, on: app.db)
        
        try app.test(.PUT, "\(playersURI)\(player2.id!)", beforeRequest: { req in
            try req.content.encode(playerData)
        }, afterResponse: { response in
            let returnedPlayer = try response.content.decode(Player.self)
            
            XCTAssertEqual(returnedPlayer.firstName, playerData.firstName)
            XCTAssertEqual(returnedPlayer.lastName, playerData.lastName)
            XCTAssertEqual(returnedPlayer.playerNumber, playerData.playerNumber)
            XCTAssertEqual(returnedPlayer.height, playerData.height)
            XCTAssertEqual(returnedPlayer.position, playerData.position)
            XCTAssertEqual(returnedPlayer.$currentTeam.id, playerData.teamID)
            XCTAssertEqual(returnedPlayer.id, player2.id)
            
            try app.test(.GET, playersURI, afterResponse: { secondResponse in
                let players = try secondResponse.content.decode([Player].self)
                XCTAssertEqual(players.count, 1)
                XCTAssertEqual(players[0].firstName, playerData.firstName)
                XCTAssertEqual(players[0].lastName, playerData.lastName)
                XCTAssertEqual(players[0].playerNumber, playerData.playerNumber)
                XCTAssertEqual(players[0].height, playerData.height)
                XCTAssertEqual(players[0].position, playerData.position)
                XCTAssertEqual(players[0].$currentTeam.id, playerData.teamID)
                XCTAssertEqual(players[0].id, player2.id)
            })
        })
    }
    
    // MARK: - Test Get Team Route
    func testTeamCanBeRetreivedFromAPI() throws {
        let team = try Team.create(on: app.db)
        let player =  try Player.create(firstName: "Lebron", lastName: "James", playerNumber: 10, height: 200, position: .blocker, teamID: team.id!, on: app.db)
        let _ = try Player.create(teamID: team.id!, on: app.db)
        
        try app.test(.GET, "\(playersURI)\(player.id!)/team", afterResponse: { response in
            let returnedTeam = try response.content.decode(Team.self)
            XCTAssertEqual(returnedTeam.name, team.name)
            XCTAssertEqual(returnedTeam.wins, team.wins)
            XCTAssertEqual(returnedTeam.losses, team.losses)
        })
    }
}
