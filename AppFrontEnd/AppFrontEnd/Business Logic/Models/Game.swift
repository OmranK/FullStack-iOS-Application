//
//  Match.swift
//  AppFrontEnd
//
//  Created by Omran Khoja on 12/12/21.
//

import Foundation

struct Game: Codable, Identifiable, CustomStringConvertible {
    var id: UUID?
    let date: Date
    var location: String
    var homeTeam: Team
    var awayTeam: Team
}

struct GameTeam: Codable {
    var id: UUID
    
    init(id: UUID) {
        self.id = id
    }
}

// Used in SwiftUI Previews
extension Game {

//    static func fakeTeam () -> Game {
//        let team1 = GameTeam(id: UUID())
//        let team2 = GameTeam(id: UUID())
//        return   Game(date: Date(), location: "Crypto.com Stadium", homeTeam: team1, awayTeam: team2)
//    }

    static func fakeTeams() -> [Game] {
//        let team1 = GameTeam(id: UUID())
//        let team2 = GameTeam(id: UUID())
        let team1 = Team(id: UUID(), name: "FloridaICAN", wins: 2, losses: 1, teamPicture: "Teams/floridaICAN-img")
        let team2 = Team(id: UUID(), name: "FloridaICAN", wins: 2, losses: 1, teamPicture: "Teams/floridaICAN-img")
        return [
            Game(date: Date(), location: "Crypto.com Stadium", homeTeam: team1, awayTeam: team2),
            Game(date: Date(), location: "Madison Square Garden", homeTeam: team1, awayTeam: team2),
            Game(date: Date(), location: "", homeTeam: team1, awayTeam: team2),
            Game(date: Date(), location: "", homeTeam: team1, awayTeam: team2)
        ]
    }
}
