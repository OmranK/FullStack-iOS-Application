//
//  PopularDestinationsView.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 11/20/21.
//

import SwiftUI



// MARK: - Destinations

struct HighlightsView: View {
    let destinations: [Highlight] = [
        .init(name: "Paris", country: "France",  imageName: "Destinations/eiffel_tower"),
        .init(name: "New York", country: "USA",  imageName: "Destinations/new_york"),
        .init(name: "Tokyo", country: "Japan",  imageName: "Destinations/japan"),
        .init(name: "Paris", country: "France",  imageName: "Destinations/eiffel_tower"),
        .init(name: "New York", country: "USA",  imageName: "Destinations/new_york"),
        .init(name: "Tokyo", country: "Japan",  imageName: "Destinations/japan"),
    ]
    
    var body: some View {
        VStack {
            // Horizontal Stack  ⎣⎦⬌⎣⎦
            HStack {
                Text("Highlights")
                    .font(.system(size: 14, weight: .semibold))
                
                Spacer()
                
                Text("See All")
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Horizontal Scroll View < ⎣⎦⎣⎦ >
            ScrollView(.horizontal, showsIndicators: false) {
                
                // Horizontal Stack   ⎣⎦⬌⎣⎦ //
                HStack(spacing: 7) {
                    
                    // / Loop 15 Unique Objects ⎣⎦, ⎣⎦, ⎣⎦,
                    ForEach(destinations, id: \.self) { destination in
                        
                        // ⎣⎦⬍⎣⎦
                        VStack(alignment: .leading) {
                            
                            Image(destination.imageName)
                            // Settings
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                            // Pos Settings
                                .cornerRadius(5)
                                .padding(.horizontal, 6)
                                .padding(.top, 6)
                            
                            Text(destination.name)
                            // Settings
                                .font(.system(size: 10, weight: .semibold))
                            // Pos Settings
                                .padding(.horizontal, 10)
                            
                            Text(destination.country)
                            // Settings
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(Color(.lightGray))
                            // Pos Settings
                                .padding(.horizontal, 10)
                                .padding(.bottom, 5)
                        }
                        .asTile()
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightsView()
//        HomeView()
    }
}
