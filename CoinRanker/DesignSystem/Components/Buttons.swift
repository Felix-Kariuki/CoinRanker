//
//  Buttons.swift
//  CoinRanker
//
//  Created by Felix kariuki on 28/06/2025.
//

import SwiftUI


struct PrimaryButton: View {
    let text: String
    let onClick: () -> Void
    var isLoading: Bool = false
    var buttonDisabled: Bool = false
    var fontSize: CGFloat = 16
    var fontFamily: String = Fonts.urbanistBold

    var body: some View {
        Button(action: onClick) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Theme.onPrimaryAccent))
                } else {
                    CommonText(
                        text: text,
                        fontFamily: fontFamily,
                        fontSize: fontSize,
                        textColor: Theme.onPrimaryAccent
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(14)
        }
        .background(
            isLoading ? Theme.deepGrayColor
                          : (!buttonDisabled ? Theme.primaryColor : Theme.deepGrayColor)
        )
        .clipShape(RoundedRectangle(cornerRadius: 100))
        .frame(maxWidth: .infinity)
        .disabled(buttonDisabled || isLoading)
    }
}

struct SecondaryButton: View {
    
    let text: String
    let onClick: () -> Void
    var isLoading: Bool = false
    var buttonDisabled:Bool = false
    var fontSize: CGFloat = 16
    var fontFamily: String = Fonts.urbanistBold
    
    var body: some View {
        Button(action: onClick) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Theme.onPrimaryAccent))
                } else {
                    CommonText(text: text, fontFamily: fontFamily,
                             fontSize: fontSize,
                             textColor: buttonDisabled ? Theme.onPrimaryAccent : Theme.buttonSurvaceVariantText)
                }
            }
                .frame(maxWidth: .infinity)
                .padding(14)
        }
        .background(isLoading ? Theme.deepGrayColor : ( !buttonDisabled ? Theme.buttonSurvaceVariant : Theme.deepGrayColor)  )
        .clipShape(RoundedRectangle(cornerRadius: 100))
        .frame(maxWidth: .infinity)
        .disabled(buttonDisabled || isLoading)
    }
}


#Preview {
    Group{
        PrimaryButton(text: "SignIn", onClick: {},isLoading: false,buttonDisabled: false)
            .padding()
        
    
        SecondaryButton(text: "SignIn", onClick: {},isLoading: false, buttonDisabled: false)
            .padding()
    }
    
}
