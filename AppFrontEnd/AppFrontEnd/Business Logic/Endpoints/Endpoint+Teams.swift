//
//  Endpoint+Team.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

import Foundation


extension Endpoint {
    
    static var teams: Self {
        return Endpoint(path: "/teams")
    }
    
    static func team(id: UUID) -> Self {
        return Endpoint(path: "/teams/\(id)")
    }
    
    static func teamRoster(teamID: UUID) -> Self {
        return Endpoint(path: "/teams/\(teamID)/players")
    }
    
    static func teamImage(id: UUID) -> Self {
        return Endpoint(path: "/teams/\(id)/teamPhoto")
    }

}
