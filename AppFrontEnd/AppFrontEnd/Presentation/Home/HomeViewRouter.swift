//
//  HomeViewRouter.swift
//  AppFrontEnd
//
//  Created by Omran Khoja on 12/12/21.
//

import Foundation
import SwiftUI


final class HomeViewRouter {
    
    @ViewBuilder
    public static func destinationForTappedCategory(_ category: Category) -> some View {
        switch category.id {
        case 0:
            TeamsConfigurator.configureTeamsView(with: TeamsViewModel(networkingService: TeamsService()))
            
            // Implement additional destinations here as I go
            
        default:
            CategoryDetailsView()
        }
    }
    
}
