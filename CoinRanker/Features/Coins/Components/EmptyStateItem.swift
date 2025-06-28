//
//  EmptyStateItem.swift
//  CoinRanker
//
//  Created by Felix kariuki on 28/06/2025.
//

import Foundation
import SwiftUI

struct EmptyStateItem: View {
    var title:String = "No Coins Found"
    var description:String = "An unknown error occurred"
    var showRetryButton:Bool = false
    var showError:Bool = false
    var onRetry:() ->Void = {}
    
    var body: some View {
        VStack{
            Image( "btc")
                .resizable()
                .frame(width: 150, height: 120)
            BodyLargeText(text: title)
            
            if showError {
                VerticalSpacer(size: .medium)
                BodyMediumText(text: description)
            }
            
            if showRetryButton {
                PrimaryButton(text: "Retry", onClick: {})
                    .frame(width: 150)
            }
        }.padding(.horizontal)
    }
}


#Preview {
    EmptyStateItem()
}
