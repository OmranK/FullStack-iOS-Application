//
//  TrendingPlayersView.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 11/20/21.
//

import SwiftUI

// MARK: - TrendingPlayersView


struct TrendingPlayersView: View {
    
    
    let players: [User] = [
        .init(firstName: "Amy", lastName: "Adams", imageName: "Users/amy"),
        .init(firstName: "Billy", lastName: "Childs",  imageName: "Users/billy"),
        .init(firstName: "Sam", lastName: "Smith", imageName: "Users/sam"),
    ]
    
    var body: some View {
        // ⎣⎦⬍⎣⎦
        VStack {
            // ⎣⎦⬌⎣⎦
            HStack {
                Text("Trending Players")
                    .font(.system(size: 14, weight: .semibold))
                
                Spacer()
                
                Text("See All")
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Horizontal Scroll View < ⎣⎦⎣⎦ >
            ScrollView(.horizontal, showsIndicators: false) {
                
                // ⎣⎦⬌⎣⎦
                HStack(spacing: 12) {
                    
                    // / Loop 15 Unique Objects ⎣⎦, ⎣⎦, ⎣⎦,
                    ForEach(players, id: \.self) { creator in
                        
                        // ⎣⎦⬍⎣⎦
                        VStack(alignment: .center) {
                            
                            Image(creator.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .cornerRadius(.infinity)
                            Text("\(creator.firstName) \n\(creator.lastName) ")
                                .font(.system(size: 10, weight: .semibold))
                                .multilineTextAlignment(.center)
                            
                        }
                        .frame(width: 60)
                        .shadow(color: .gray, radius: 4, x: 0.0, y: 2.0)
                        .padding(.bottom)
                        
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


struct TrendingPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingPlayersView()
    }
}
