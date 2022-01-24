//
//  TravelDiscoveryAppApp.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 11/19/21.
//

import SwiftUI
import Combine
@main
struct AppFrontEnd: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
//            configureHomeView()
//            TeamsConfigurator.configureTeamsView(with: TeamsViewModel(networkingService: TeamsService()))
        }
    }
}

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
}
