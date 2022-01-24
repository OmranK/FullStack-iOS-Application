//
//  TeamsRouter.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import SwiftUI

final class TeamsRouter {
    
    public static func destinationForTappedTeam(team: Team) -> some View {
        return TeamDetailConfigurator.configureTeamDetailView(with: team)
    }
    
    public static func destinationForCreateNewTeam() -> some View {
        return CreateNewTeamConfigurator.configureCreateNewTeamView()
    }
}

