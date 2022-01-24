//
//  HomeViewModel.swift
//  AppFrontEnd
//
//  Created by Omran Khoja on 12/12/21.
//

import Foundation

import Combine

final class HomeViewModel: ObservableObject {
    
    @Published public var upcomingGames: [Game]
    
    private var networkingService: GamesServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    let categories: [Category] = [
        Category(id: 0, name: "Teams", imageName: "person.3.fill"),
        Category(id: 1, name: "Players", imageName: "person.fill"),
        Category(id: 2, name: "Rankings", imageName: "calendar.day.timeline.leading"),
        Category(id: 3, name: "Games", imageName: "bolt.horizontal.fill"),
        Category(id: 4, name: "Tickets", imageName: "ticket"),
        Category(id: 5, name: "Live Events", imageName: "eye.circle.fill"),
    ]
    
    init(upcomingGames: [Game] = Game.fakeTeams(), networkingService: GamesServiceProtocol = GamesService()) {
        self.networkingService = networkingService
        self.upcomingGames = upcomingGames
    }
    
    public func onAppear() {
        self.getGames()
    }
    
    private func getGames() {
        networkingService.getGames()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { teams in
                self.upcomingGames = teams
            }
            .store(in: &cancellables)
    }
    
//    private func getHomeTeam(teamID: UUID) -> Team {
//
//        networkingService.getTeam(teamID: teamID)
//            .sink { completion in
//                switch completion {
//                case .failure(let error):
//                    print(error)
//                case .finished: break
//                }
//            } receiveValue: { team in
//                return team
//            }
//            .store(in: &cancellables)
//    }
//
//    private func getAwayTeam(teamID: UUID {
//        networkingService.getTeam(id: teamID)
//            .sink { completion in
//                switch completion {
//                case .failure(let error):
//                    print(error)
//                case .finished: break
//                }
//            } receiveValue: { teams in
//                self.upcomingGames = teams
//            }
//            .store(in: &cancellables)
//    }
    
}

// MARK: -  Categories

struct Category: Hashable {
    let id: Int
    let name, imageName: String
}
