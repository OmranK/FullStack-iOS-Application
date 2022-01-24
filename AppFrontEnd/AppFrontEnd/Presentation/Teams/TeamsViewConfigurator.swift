//
//  TeamsConfigurator.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation

final class TeamsConfigurator {
    
    public static func configureTeamsView(with viewModel: TeamsViewModel) -> TeamsView {
        let teamsView = TeamsView(viewModel: viewModel)
        return teamsView
    }
}
