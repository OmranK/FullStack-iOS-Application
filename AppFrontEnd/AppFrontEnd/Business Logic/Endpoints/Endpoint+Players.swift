//
//  Endpoint+Players.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

import Foundation

extension Endpoint {
    
    static var players: Self {
        return Endpoint(path: "/players")
    }

    
    static func player(id: UUID) -> Self {
        return Endpoint(path: "/players/\(id)")
    }
    
}



//
//    static func users(count: Int) -> Self {
//        return Endpoint(path: "/user", queryItems: [
//            URLQueryItem(name: "limit", value: "\(count)")
//        ])
//    }
