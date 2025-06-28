//
//  SVGIcon.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import SwiftUI

struct SVGIcon: View {
    let iconName: String
    let size: CGFloat
    let color: Color
    
    init(_ iconName: String, size: CGFloat = 20, color: Color = .primary) {
        self.iconName = iconName
        self.size = size
        self.color = color
    }
    
    var body: some View {
        Image(iconName)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .foregroundColor(color)
    }
}
