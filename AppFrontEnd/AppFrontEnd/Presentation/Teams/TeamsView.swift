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
struct TeamsView: View {
    
    @State private var searchQuery: String = ""
    @State private var screenWidth = UIScreen.main.bounds.width
    @State private var screenHeight = UIScreen.main.bounds.height
    
    @ObservedObject var viewModel: TeamsViewModel
    
    
    init(viewModel: TeamsViewModel) {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6996605992, green: 0.2329967618, blue: 0.4832239747, alpha: 1)), Color(#colorLiteral(red: 0.231372549, green: 0.09411764706, blue: 0.3725490196, alpha: 1))]), startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
            Color.homePageBackground.offset(y: screenHeight/3)
            
            ScrollView(.vertical) {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack(alignment: .top){
                        TextField("Search Team", text: $searchQuery)
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(Color.secondary)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
                    }
                    .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
                    //                        .offset(y: -screenHeight/3)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.teams) { team in
                            NavigationLink(destination: TeamsRouter.destinationForTappedTeam(team: team)) {
                                HStack {
                                    // Replace with custom Networking Component for Image Download
                                    // View should not perform networking even if it is async
                                    // Violates single responsibility principle
                                    AsyncImage(url: URL(string: "http://127.0.0.1:8080/api/teams/\(team.id!)/teamPhoto")) { image in
                                        image.withTeamsViewImageStyle()
                                    } placeholder: {
//                                        Image(team.teamPicture!).withTeamsViewImageStyle()
                                        ProgressView()
                                    }
                                    .frame(width: 80, height: 80)
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                                    .padding()
                                    
                                    VStack(alignment: .leading) {
                                        Text(team.name)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        HStack {
                                            Text("Wins: \(team.wins)")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.gray)
                                            Text("Losses: \(team.losses)")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.gray)
                                        }
                                        .padding(.top, 1)
                                    }
                                    
                                    Spacer()
                                }
                                .onAppear(perform: { viewModel.onAppear() })
                            }
                            Divider().background(Color.gray).frame(width: screenWidth)
                        }
                    }
                    .background(Color.homePageBackground)
                    .cornerRadius(16)
                    .padding(.top, 16)
                }
                
            }
            .navigationTitle("Official Teams")
            .navigationBarItems(
                trailing: Button(action: {}, label: {
                    NavigationLink(destination: TeamsRouter.destinationForCreateNewTeam()) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                })
            )
        }
    }
}


struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView(viewModel: TeamsViewModel())
    }
}
