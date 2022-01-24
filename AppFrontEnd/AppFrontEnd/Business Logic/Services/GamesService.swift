//
//  GamesService.swift
//  AppFrontEnd
//
//  Created by Omran Khoja on 12/12/21.
//

import Foundation
import Combine

// Prototype for
protocol GamesServiceProtocol: AnyObject {
    var networker: NetworkingProtocol { get }
    func getGames() -> AnyPublisher<[Game], NetworkRequestError>
    func getTeam(teamID: UUID) -> AnyPublisher<Team, NetworkRequestError>
}


final class GamesService: GamesServiceProtocol {
    
    let networker: NetworkingProtocol
    
    init(networker: NetworkingProtocol = NetworkDispatcher()) {
        self.networker = networker
    }
    
    func getGames() -> AnyPublisher<[Game], NetworkRequestError> {
        let endpoint = Endpoint.games
        let request = Request<[Game]>(method: .get)
        guard let urlRequest = request.asURLRequest(url: endpoint.url) else {
            return Fail(outputType: [Game].self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        return networker.dispatch(request: urlRequest)
    }
    
    func getTeam(teamID: UUID) -> AnyPublisher<Team, NetworkRequestError> {
        let endpoint = Endpoint.team(id: teamID)
        let request = Request<Team>(method: .get)
        guard let urlRequest = request.asURLRequest(url: endpoint.url) else {
            return Fail(outputType: Team.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        return networker.dispatch(request: urlRequest)
    }
}
