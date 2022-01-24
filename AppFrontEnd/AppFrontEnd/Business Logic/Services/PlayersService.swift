//
//  PlayersService.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

import Foundation
import Combine

// Prototype for 
protocol PlayersServiceProtocol: AnyObject {
    var networker: NetworkingProtocol { get }
    func getPlayers() -> AnyPublisher<[Player], NetworkRequestError>
    func getPlayer(id: UUID) -> AnyPublisher<Player, NetworkRequestError>
}


final class PlayersService: PlayersServiceProtocol {
    
    let networker: NetworkingProtocol
    
    init(networker: NetworkingProtocol = NetworkDispatcher()) {
        self.networker = networker
    }
    
    func getPlayers() -> AnyPublisher<[Player], NetworkRequestError> {
        let endpoint = Endpoint.players
        let request = Request<[Player]>(method: .get)
        guard let urlRequest = request.asURLRequest(url: endpoint.url) else {
            return Fail(outputType: [Player].self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        return networker.dispatch(request: urlRequest)
    }
    
    func getPlayer(id: UUID) -> AnyPublisher<Player, NetworkRequestError> {
        let endpoint = Endpoint.player(id: id)
        let request = Request<Player>(method: .get)
        guard let urlRequest = request.asURLRequest(url: endpoint.url) else {
            return Fail(outputType: Player.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        return networker.dispatch(request: urlRequest)
    }
}
