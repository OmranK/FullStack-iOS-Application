//
//  RestaurantsView.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 11/20/21.
//

//import SwiftUI


// MARK: - PlacesToEatView
//
//struct PlacesToEatView: View {
//
//    let restaurants: [Restaurant] = [
//        .init(name: "Japan's Finest Tapas",
//              cost: "$$",
//              imageName: "Restaurants/tapas",
//              location:"Tokyo, Japan",
//              type: "Sushi",
//              rating: 4.8),
//
//            .init(name: "Japan Bar & Grill",
//                  cost: "$$",
//                  imageName: "Restaurants/bar_grill",
//                  location:"Tokyo, Japan",
//                  type: "BBQ",
//                  rating: 4.7)
//    ]
//
//    var body: some View {
//        // Vertical Stack ⎣⎦⬍⎣⎦
//        VStack {
//            // Horizontal Stack ⎣⎦⬌⎣⎦
//            HStack {
//                Text("Popular Destinations")
//                    .font(.system(size: 14, weight: .semibold))
//                Spacer()
//                Text("See All")
//                    .font(.system(size: 14, weight: .semibold))
//            }
//            .padding(.horizontal)
//            .padding(.top)
//
//            // Horizontal Scroll View < ⎣⎦⎣⎦ >
//            ScrollView(.horizontal, showsIndicators: false) {
//
//                // ⎣⎦⬌⎣⎦ //
//                HStack(spacing: 7) {
//
//                    // Loop 15 Unique Objects ⎣⎦, ⎣⎦, ⎣⎦,
//                    ForEach(restaurants, id: \.self) { restaurant in
//
//
//                        // ⎣⎦⬌⎣⎦
//                        HStack() {
//
//                            // /
//                            Image(restaurant.imageName)
//                            // Settings
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 50, height: 50)
//                            // Pos Settings
//                                .cornerRadius(5)
//                                .padding(.leading, 6)
//                                .padding(.vertical, 6)
//
//                            // / ⎣⎦⬍⎣⎦
//                            VStack(alignment: .leading, spacing: 6) {
//
//                                // // ⎣⎦⬌⎣⎦
//                                HStack() {
//                                    Text(restaurant.name)
//                                    Spacer()
//                                    Button(action: {}, label: {
//                                        Image(systemName: "ellipsis") .foregroundColor(.gray)
//                                    })
//                                }
//                                .padding(.trailing, 6)
//
//                                // // ⎣⎦⬌⎣⎦
//                                HStack() {
//                                    Image(systemName: "star.fill")
//                                    Text("\(String(restaurant.rating)) • \(restaurant.type) • $$")
//                                }
//
//                                // //
//                                Text(restaurant.location)
//
//                            }.font(.system(size: 9, weight: .semibold))
//                        }
//                        .frame(width: 200)
//                        .modifier(TileModifier())
//                    }
//                }
//                .padding(.horizontal)
//            }
//        }
//    }
//}
//
//
//struct PlacesToEatView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlacesToEatView()
//        HomeView()
//    }
//}
