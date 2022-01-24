//
//  TileModifier.swift
//  TravelDiscoveryApp
//
//  Created by Omran Khoja on 11/20/21.
//

import SwiftUI

extension View {
    func asTile () -> some View {
        modifier(TileModifier())
    }
}

struct TileModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white)
            .cornerRadius(5)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            .padding(.bottom)
    }
}
