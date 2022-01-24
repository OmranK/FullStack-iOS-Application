//
//  PlayersView.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/9/21.
//

import Foundation
import Combine

class PlayerssViewModel: ObservableObject {
    
    @Published public var players: [Player]
    
    private var playersService: PlayersServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(players: [Player] = [], playersService: PlayersServiceProtocol = PlayersService()) {
        self.players = players
        self.playersService = playersService
    }
    
    public func onAppear() {
        self.getPlayers()
    }
    
    private func getPlayers() {
        playersService.getPlayers()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { players in
                self.players = players
            }
            .store(in: &cancellables)
    }
}
    
