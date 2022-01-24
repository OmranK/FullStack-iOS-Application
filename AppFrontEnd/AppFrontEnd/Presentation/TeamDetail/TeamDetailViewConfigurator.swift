//
//  TeamsConfigurator.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation

final class TeamDetailConfigurator {
    
    public static func configureTeamDetailView(with team: Team) -> TeamDetailView {
        let teamsView = TeamDetailView(viewModel: TeamDetailViewModel(team: team))
        return teamsView
    }
    
}
