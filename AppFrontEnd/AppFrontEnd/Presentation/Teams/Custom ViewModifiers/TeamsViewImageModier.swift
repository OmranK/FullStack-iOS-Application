//
//  TeamsViewImageModier.swift
//  AppFrontEnd
//
//  Created by Omran Khoja on 12/12/21.
//

import Foundation
import SwiftUI


extension Image {
    func withTeamsViewImageStyle() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
        //  .frame(width: screenWidth * 0.15, height: screenWidth * 0.15, alignment: .center)
            .frame(width: 80, height: 80)
        //  .clipShape(Circle())
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(radius: 10)
            .padding()
    }
}
