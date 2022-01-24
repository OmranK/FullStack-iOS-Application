//
//  CreateNewTeamConfigurator.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation

final class CreateNewTeamConfigurator {
    
    public static func configureCreateNewTeamView() -> CreateNewTeamView {
        let createNewTeamView = CreateNewTeamView(viewModel: CreateNewTeamViewModel())
        return createNewTeamView
    }
    
}
