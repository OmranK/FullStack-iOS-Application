//
//  File.swift
//  
//
//  Created by Omran Khoja on 12/9/21.
//

@testable import App
import Fluent
import Foundation

extension Team {
    static func create(name: String = "Cuba", wins: Int = 10, losses: Int = 6, on database: Database) throws -> Team {
        let team = Team(name: name, wins: wins, losses: losses)
        try team.save(on: database).wait()
        return team
    }
}

extension Player {
    static func create(firstName: String = "Lebron", lastName: String = "James", playerNumber: Int = 10, height: Int =  200, position: Player.PlayerPosition = .blocker, teamID: UUID, on database: Database) throws -> Player {
        let player = Player(firstName: firstName, lastName: lastName, playerNumber: playerNumber, height: height, position: position, teamID: teamID)
        try player.save(on: database).wait()
        return player
    }
}

extension Game {
    static func create(date: Date = Date("2022-06-06T23:30:00Z"), location: String = "Crypto.com Arena", homeTeamID: UUID, awayTeamID: UUID, on database: Database) throws -> Game {
        let game = Game(date: date, location: location, homeTeamID: homeTeamID, awayTeamID: awayTeamID)
        try game.save(on: database).wait()
        return game
    }
}
