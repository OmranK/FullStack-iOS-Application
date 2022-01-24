//
//  RestaurantsView.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 11/20/21.
//

import SwiftUI

struct UpcomingGamesView: View {

    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Upcoming Matches")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See All")
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 7) {

                    ForEach(viewModel.upcomingGames) { game in
                        HStack() {
                            AsyncImage(url: URL(string: "http://127.0.0.1:8080/api/teams/\(game.homeTeam.id!)/teamPhoto")) { image in
                                image
                                    .resizable()
                            } placeholder: {
//                                Image(team.teamPicture!).withTeamsViewImageStyle()
                                ProgressView()
                            }
                            // Settings
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                            // Pos Settings
                                .cornerRadius(5)
                                .padding(.leading, 6)
                                .padding(.vertical, 6)

                            VStack(alignment: .leading, spacing: 6) {
                                HStack() {
                                    Text(game.homeTeam.name)
                                    Spacer()
                                    Button(action: {}, label: {
                                        Image(systemName: "ellipsis") .foregroundColor(.gray)
                                    })
                                }
                                .padding(.trailing, 6)

                                HStack() {
                                    Image(systemName: "star.fill")
//                                    Text("\(String(restaurant.rating)) • \(restaurant.type) • $$")
                                }

//                                Text(restaurant.location)

                            }
                            .font(.system(size: 9, weight: .semibold))
                            
                            .onAppear(perform: { viewModel.onAppear() })
                        }
                        .frame(width: 200)
                        .modifier(TileModifier())
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


struct UpcomingGamesView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingGamesView(viewModel: HomeViewModel())
        HomeView()
    }
}
