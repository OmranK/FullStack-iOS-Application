//
//  CreateNewTeamViewModel.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation
import Combine

final class CreateNewTeamViewModel: ObservableObject {
    
    private var networkingService: TeamsServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkingService: TeamsServiceProtocol = TeamsService()) {
        self.networkingService = networkingService
    }
    
    func createTeam(name: String) {
        print("create \(name)")
        let newTeam = Team(name: name)
        
        networkingService.create(newTeam)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    let _ = print(error)
                case .finished: break
                }
            } receiveValue: { _ in  }
            .store(in: &cancellables)
    }
}
