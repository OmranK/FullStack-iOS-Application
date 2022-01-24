//
//  ContentView.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 11/19/21.
//

import SwiftUI

extension Color {
    static let homePageBackground = Color(.init(white: 0.9, alpha: 1))
}

// MARK: - HomeView
struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6996605992, green: 0.2329967618, blue: 0.4832239747, alpha: 1)), Color(#colorLiteral(red: 0.231372549, green: 0.09411764706, blue: 0.3725490196, alpha: 1))]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                Color.homePageBackground.offset(y: 500)
                
                ScrollView {
                    CategoriesView(viewModel: viewModel)
                    
                    
                    VStack {
                        HighlightsView()
                        UpcomingGamesView(viewModel: viewModel)
                        TrendingPlayersView()
                    }
                    .background(Color.homePageBackground)
                    .cornerRadius(16)
                    .padding(.top, 16)
                }
                .navigationTitle("Explore")
                //.navigationBarTitleDisplayMode(.inline)   // Option
            }
        }.accentColor( .white)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
