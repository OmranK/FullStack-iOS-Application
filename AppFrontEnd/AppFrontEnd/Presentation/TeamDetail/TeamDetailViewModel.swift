//
//  TeamsViewModel.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation
import Combine

class TeamDetailViewModel: ObservableObject {
    
    // Networking Dependency (Protocol so implementation can be changed easily)
    private var networkingService: TeamsServiceProtocol
    
    // Store Combine async calls (Subscriptions)
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var team: Team
    @Published public var roster: [Player]
    
    
    init(team: Team, roster: [Player] = [], networkingService: TeamsServiceProtocol = TeamsService()) {
        self.team = team
        self.roster = roster
        self.networkingService = networkingService
    }
    
    public func onAppear() {
        self.getRoster()
    }
    
    private func getRoster() {
        if let teamID = team.id {
            networkingService.getRoster(teamID: teamID)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                    case .finished: break
                    }
                } receiveValue: { [weak self] roster in
                    self?.roster = roster
                }
                .store(in: &cancellables)
        }
    }
}
