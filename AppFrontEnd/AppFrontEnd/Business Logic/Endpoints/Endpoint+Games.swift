//
//  Endpoint+Games.swift
//  AppFrontEnd
//
//  Created by Omran Khoja on 12/12/21.
//

import Foundation

extension Endpoint {
    
    static var games: Self {
        return Endpoint(path: "/games")
    }
    
    static var sortedGames: Self {
        return Endpoint(path: "/games/sorted")
    }
    
}
