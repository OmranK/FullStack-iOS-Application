//
//  Team.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

import Foundation

struct Team: Codable, Identifiable, CustomStringConvertible {
    var id: UUID?
    let name: String
    var wins: Int = 0
    var losses: Int = 0
    var teamPicture: String?
}

// Used in SwiftUI Previews
extension Team {
    
    static func fakeTeam () -> Team {
        return Team(id: UUID(), name: "FloridaICAN", wins: 2, losses: 1, teamPicture: "Teams/floridaICAN-img")
    }
    
    static func fakeTeams() -> [Team] {
        return [
            Team(id: UUID(), name: "FloridaICAN", wins: 2, losses: 1, teamPicture: "Teams/floridaICAN-img"),
            Team(id: UUID(), name: "Dominican Republic", wins: 2, losses: 1, teamPicture: "Teams/dominicanRepIMG"),
            Team(id: UUID(), name: "FloridaICAN", wins: 2, losses: 1, teamPicture: "Teams/floridaICAN-img"),
            Team(id: UUID(), name: "Dominican Republic", wins: 2, losses: 1, teamPicture: "Teams/dominicanRepIMG"),
        ]
    }
}


