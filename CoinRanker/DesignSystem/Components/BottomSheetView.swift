//
//  Untitled.swift
//  CoinRanker
//
//  Created by Felix kariuki on 28/06/2025.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Binding var isShowing: Bool
    let content: () -> Content
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isShowing = false
                        }
                    }

                VStack {
                    Spacer().frame(height: spacing.small)
                    Rectangle()
                        .frame(width: 40,height: 4)
                        .foregroundStyle(Theme.textGray.opacity(0.15))
                        .cornerRadius(100)
                    Spacer().frame(height: spacing.extraMedium)
                    
                    content()
                }
                .frame(maxWidth: .infinity)
                .background( colorScheme == .light ? Theme.backgroundGrayColor : Theme.backgroundGrayColor)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}


#Preview {
    BottomSheetView(isShowing: .constant(true)) {
        FilterBottomSheet(
            onCancel: {},
            onApply: {},
            viewModel: CoinsViewModel())
    }
}
