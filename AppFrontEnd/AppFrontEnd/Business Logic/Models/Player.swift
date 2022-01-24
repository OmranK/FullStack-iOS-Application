//
//  Player.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

import Foundation

struct Player: Codable, Identifiable, CustomStringConvertible {
    
    enum PlayerPosition: String, Codable {
        case advancer = "Advancer"
        case aimeeter = "Aimeeter"
        case blocker = "Blocker"
        case participer = "Participer"
    }
    
    var id: UUID?
    let firstName: String
    let lastName: String
    let playerNumber: Int
    let height: Int
    let position: PlayerPosition
    let currentTeam: PlayerTeam
    let playerPicture: String?
}


struct PlayerTeam: Codable {
    var id: UUID
    
    init(id: UUID) {
        self.id = id
    }
}



extension Player {
    static func fakePlayer() -> Player {
        return Player(id: UUID(), firstName: "First Name", lastName: "Last Name", playerNumber: 10,height: 170, position: PlayerPosition.advancer, currentTeam: PlayerTeam(id: UUID()), playerPicture: nil)
    }
    
    static func fakePlayers() -> [Player] {
        let team = PlayerTeam(id: UUID())
        return [
            Player(id: UUID(), firstName: "Martinez", lastName: "F.", playerNumber: 3  , height: 178, position: .advancer, currentTeam: team, playerPicture: "Players/martinez03"),
            Player(id: UUID(), firstName: "Adam", lastName: "K.", playerNumber: 1  , height: 180, position: .aimeeter, currentTeam: team, playerPicture: "Players/adam01"),
            Player(id: UUID(), firstName: "Sama", lastName: "C.", playerNumber: 8  , height: 175, position: .advancer, currentTeam: team, playerPicture: "Players/sama08"),
            Player(id: UUID(), firstName: "Louis", lastName: "W.", playerNumber: 9  , height: 169, position: .participer, currentTeam: team, playerPicture: "Players/louis09"),
            Player(id: UUID(), firstName: "Benitez", lastName: "D.", playerNumber: 13 , height: 182, position: .advancer, currentTeam: team, playerPicture: "Players/benitez13"),
            Player(id: UUID(), firstName: "Granados", lastName: "J.", playerNumber: 14 , height: 173, position: .participer, currentTeam: team, playerPicture: "Players/granados14"),
            Player(id: UUID(), firstName: "Lormon", lastName: "A.", playerNumber: 22 , height: 178, position: .blocker, currentTeam: team, playerPicture: "Players/lormon22"),
            Player(id: UUID(), firstName: "Lobo", lastName: "S.", playerNumber: 99 , height: 176, position: .aimeeter, currentTeam: team, playerPicture: "Players/lobo99"),
            Player(id: UUID(), firstName: "Castro", lastName: "B.", playerNumber: 100, height: 165, position: .blocker, currentTeam: team, playerPicture: "Players/castro100")
            ]
    }

}
