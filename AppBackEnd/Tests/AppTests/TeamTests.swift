@testable import App
import XCTVapor

final class TeamTests: XCTestCase {
    
    // MARK: - Team Tests Default Environment Variables
    let team = Team(name: "Haiti", wins: 8, losses: 8)
    let teamsURI = "/api/teams/"
    var app: Application!
    
    // MARK: - Test Lifecycle Functions (Runs before and after each test)
    override func setUpWithError() throws {
        app = try Application.testable()
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }
    
    // MARK: - Test Create Route
    func testTeamCanBeSavedWithAPI() throws {
        
        try app.test(.POST, teamsURI, beforeRequest: { req in
            try req.content.encode(team)
        }, afterResponse: { response in
            let receivedTeam = try response.content.decode(Team.self)
            XCTAssertEqual(receivedTeam.name, team.name)
            XCTAssertEqual(receivedTeam.wins, team.wins)
            XCTAssertEqual(receivedTeam.losses, team.losses)
            XCTAssertNotNil(receivedTeam.id)
            
            try app.test(.GET, teamsURI, afterResponse: { secondResponse in
                let teams = try secondResponse.content.decode([Team].self)
                XCTAssertEqual(teams.count, 1)
                XCTAssertEqual(teams[0].name, team.name)
                XCTAssertEqual(teams[0].wins, team.wins)
                XCTAssertEqual(teams[0].losses, team.losses)
                XCTAssertEqual(teams[0].id, receivedTeam.id)
            })
        })
    }
    
    // MARK: - Test Retreive Routes
    func testTeamsCanBeRetrievedFromAPI() throws {
        let team = try Team.create(name: "Haiti", wins: 8, losses: 8, on: app.db)
        _ = try Team.create(on: app.db)
        
        try app.test(.GET, teamsURI, afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
            
            let teams = try response.content.decode([Team].self)
            XCTAssertEqual(teams.count, 2)
            XCTAssertEqual(teams[0].name, "Haiti")
            XCTAssertEqual(teams[0].wins, 8)
            XCTAssertEqual(teams[0].losses, 8)
            XCTAssertEqual(teams[0].id, team.id)
        })
    }
    
    func testSingleTeamCanBeRetrievedFromAPI() throws {
        let team = try Team.create(name: team.name, wins: team.wins, losses: team.losses, on: app.db)
        
        try app.test(.GET, "\(teamsURI)\(team.id!)", afterResponse: { response in
            let receivedTeam = try response.content.decode(Team .self)
            
            XCTAssertEqual(receivedTeam.name, team.name)
            XCTAssertEqual(receivedTeam.wins, team.wins)
            XCTAssertEqual(receivedTeam.losses, team.losses)
            XCTAssertEqual(receivedTeam.id, team.id)
        })
    }
    
    // MARK: - Test Delete Route
    func testTeamCanBeDeletedFromAPI() throws {
        let team = try Team.create(name: team.name, wins: team.wins, losses: team.losses, on: app.db)
        let team2 = try Team.create(on: app.db)
        
        try app.test(.DELETE, "\(teamsURI)\(team.id!)", afterResponse: { response in
            
            XCTAssertEqual(response.status, .noContent)
            
            try app.test(.GET, teamsURI, afterResponse: { secondResponse in
                let teams = try secondResponse.content.decode([Team].self)
                XCTAssertEqual(teams.count, 1)
                XCTAssertEqual(teams[0].name, team2.name)
                XCTAssertEqual(teams[0].wins, team2.wins)
                XCTAssertEqual(teams[0].losses, team2.losses)
                XCTAssertEqual(teams[0].id, team2.id)
            })
            
        })
    }
    
    // MARK: - Test Update Route
    func testTeamUpdatesCorrectly() throws {
        let team2 = try Team.create(on: app.db)
        
        try app.test(.PUT, "\(teamsURI)\(team2.id!)", beforeRequest: { req in
            try req.content.encode(team)
        }, afterResponse: { response in
            let returnedTeam = try response.content.decode(Team.self)
            
            XCTAssertEqual(returnedTeam.name, team.name)
            XCTAssertEqual(returnedTeam.wins, team.wins)
            XCTAssertEqual(returnedTeam.losses, team.losses)
            XCTAssertEqual(returnedTeam.id, team2.id)
            
            try app.test(.GET, teamsURI, afterResponse: { secondResponse in
                let teams = try secondResponse.content.decode([Team].self)
                XCTAssertEqual(teams.count, 1)
                XCTAssertEqual(teams[0].name, team.name)
                XCTAssertEqual(teams[0].wins, team.wins)
                XCTAssertEqual(teams[0].losses, team.losses)
                XCTAssertEqual(teams[0].id, team2.id)
            })
        })
    }
    
    // MARK: - Test Search Route
    func testTeamCanBeRetreivedFromAPISearch() throws {
        let _ = try Team.create(name: team.name, wins: team.wins, losses: team.losses, on: app.db)
        let team2 = try Team.create(on: app.db)
        
        try app.test(.GET, "\(teamsURI)search?term=Cuba", afterResponse: { response in
        
                let teams = try response.content.decode([Team].self)
                XCTAssertEqual(teams.count, 1)
                XCTAssertEqual(teams[0].name, team2.name)
                XCTAssertEqual(teams[0].wins, team2.wins)
                XCTAssertEqual(teams[0].losses, team2.losses)
                XCTAssertEqual(teams[0].id, team2.id)
        })
    }
    
    // MARK: - Test Get Players Route
    
    func testTeamPlayerRosterCanBeRetreivedFromAPI() throws {
        let team = try Team.create(on: app.db)
        let player1 = try Player.create(teamID: team.id!, on: app.db)
        _ = try Player.create(firstName: "Stephan", lastName: "Curry", playerNumber: 8, height: 180, position: .advancer, teamID: team.id!, on: app.db)
        
        try app.test(.GET, "\(teamsURI)\(team.id!)/players", afterResponse: { response in
            
            let players = try response.content.decode([Player].self)
            XCTAssertEqual(players.count, 2)
            XCTAssertEqual(players[0].firstName, player1.firstName)
            XCTAssertEqual(players[0].lastName, player1.lastName)
            XCTAssertEqual(players[0].playerNumber, player1.playerNumber)
            XCTAssertEqual(players[0].height, player1.height)
            XCTAssertEqual(players[0].position, player1.position)
            XCTAssertEqual(players[0].$currentTeam.id, player1.$currentTeam.id)
        })
    }
    
    // MARK: - Test Get Games Route
    
    func testTeamScheduledGamesCanBeRetreivedFromAPI() throws {
        let team = try Team.create(on: app.db)
        let team2 = try Team.create(name: team.name, wins: team.wins, losses: team.losses, on: app.db)
        let team3 = try Team.create(name: "USA", wins: 9, losses: 7, on: app.db)
        
        let game1 = try Game.create(homeTeamID: team.id!, awayTeamID: team2.id!, on: app.db)
        let game2 = try Game.create(homeTeamID: team.id!, awayTeamID: team3.id!, on: app.db)
        
        try app.test(.GET, "\(teamsURI)\(team.id!)/games", afterResponse: { response in
            let games = try response.content.decode([Game].self)
            XCTAssertEqual(games.count, 2)
            XCTAssertEqual(games[0].$homeTeam.id, team.id!)
            XCTAssertEqual(games[0].id, game1.id!)
            XCTAssertEqual(games[1].$homeTeam.id, team.id!)
            XCTAssertEqual(games[1].id, game2.id!)
        })
    }
}
