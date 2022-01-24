//
//  TeamsViewModel.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation
import Combine

class TeamsViewModel: ObservableObject {
    
    @Published public var teams: [Team]
    
    private var networkingService: TeamsServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(teams: [Team] = Team.fakeTeams(), networkingService: TeamsServiceProtocol = TeamsService()) {
        self.networkingService = networkingService
        self.teams = teams
    }
    
    public func onAppear() {
        self.getTeams()
    }
    
    private func getTeams() {
        networkingService.getTeams()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { teams in
                self.teams = teams
            }
            .store(in: &cancellables)
    }
}
