//
//  ManageProfileView.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 12/10/21.
//

import Foundation

import Foundation
import SwiftUI

// MARK: - NavTabView
struct TeamDetailView: View {
    
    
    @State private var showingModalSheet = false
    @State private var screenWidth = UIScreen.main.bounds.width
    @State private var screenHeight = UIScreen.main.bounds.height
    
    @ObservedObject var viewModel: TeamDetailViewModel
    
    var body: some View {
        //        VStack {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6996605992, green: 0.2329967618, blue: 0.4832239747, alpha: 1)), Color(#colorLiteral(red: 0.231372549, green: 0.09411764706, blue: 0.3725490196, alpha: 1))]), startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
            Color.homePageBackground.offset(y: screenHeight/3)
            
            HStack {
                VStack(alignment: .leading,  spacing: 10) {
                    Text("Wins: \(viewModel.team.wins)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    Text("Losses: \(viewModel.team.losses)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.leading, 20)
                Spacer()
            }
            
//            VStack(alignment: .leading)  {
//
//            }
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    ForEach(viewModel.roster) { player in
                        
//                        HStack {
//                            Spacer()
//                            Text("\(player.firstName) \(player.lastName)")
//                                .font(.system(size: 30, weight: .semibold))
//                                .foregroundColor(.black)
//                            Spacer()
//                        }
//                        .padding(.top, 10)
//
                        VStack(alignment: .leading) {
                            HStack {
                                // Replace with Networker
                                AsyncImage(url: URL(string: "http://127.0.0.1:8080/api/players/\(player.id!)/playerPhoto")) { image in
                                    image
                                        .resizable()
                                } placeholder: {
                                    Image(player.playerPicture!)
                                        .resizable()
//                                    ProgressView()
                                }
                                .scaledToFit()
                                .cornerRadius(200)
                                .frame(width: 150, height: 150)
                                .padding(.horizontal, 6)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(player.firstName) \(player.lastName)")
                                        .font(.system(size: 30, weight: .semibold))
                                        .foregroundColor(.black)
                                    Text("Number: \(player.playerNumber)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.gray)
                                    
                                    Text("Position: \(player.position.rawValue)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.gray)
                                    Text("Height: \(player.height)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.gray)
                                    
                                }
                            }
                        }
                        
                        Spacer()
                        Divider().background(Color.gray).frame(width: screenWidth)
                    }
                }
                .padding(.top, 20)
                .onAppear(perform: { viewModel.onAppear() })
            }
            .background(Color.homePageBackground)
            .cornerRadius(16)
            .offset(y: 200)
        }
        
//        .navigationBarTitle(viewModel.team.name, displayMode: .inline)
        .navigationTitle(viewModel.team.name)
//        .navigationBarItems(
//            trailing: Button(action: {}, label: {
//                NavigationLink(destination: TeamsRouter.destinationForCreateNewTeam()) {
//                    Image(systemName: "plus")
//                        .foregroundColor(.white)
//                }
//            })
//        )
    }
}

struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TeamDetailView(viewModel: TeamDetailViewModel(team: Team.fakeTeam(), roster: Player.fakePlayers()))
        }

//        HomeView()
    }
}
