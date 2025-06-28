//
//  Text.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import SwiftUI

struct CommonText: View {
    let text:String
    var fontFamily: String = Fonts.urbanistRegular
    var fontSize: CGFloat = 15
    var textColor: Color = Theme.onBackground
    var lineLimit:Int? = nil
    var alignement:TextAlignment = .leading
    var body: some View {
        
        Text(LocalizedStringKey(text))
            .foregroundColor(textColor)
            .font(.custom(fontFamily, size: fontSize))
            .lineLimit(lineLimit)
            .multilineTextAlignment(alignement)
    }
}

struct TitleLarge:View {
    let text:String
    var fontFamily: String = Fonts.urbanistExtraBold
    var fontSize: CGFloat = 24
    var textColor: Color = Theme.onBackground
    var alignement:TextAlignment = .leading
    
    var body: some View {
        CommonText(
            text: text,
            fontFamily: fontFamily,
            fontSize: fontSize,
            textColor: textColor,
            alignement: alignement
        )
    }
}

struct TitleMedium:View {
    let text:String
    var fontFamily: String = Fonts.urbanistBold
    var fontSize: CGFloat = 24
    var textColor: Color = Theme.onBackground
    var alignement:TextAlignment = .leading
    
    var body: some View {
        CommonText(
            text: text,
            fontFamily: fontFamily,
            fontSize: fontSize,
            textColor: textColor,
            alignement: alignement
        )
    }
}

struct TitleSmall:View {
    let text:String
    var fontFamily: String = Fonts.urbanistSemiBold
    var fontSize: CGFloat = 24
    var textColor: Color = Theme.onBackground
    var lineLimit:Int? = nil
    var alignement:TextAlignment = .leading
    
    var body: some View {
        CommonText(
            text: text,
            fontFamily: fontFamily,
            fontSize: fontSize,
            textColor: textColor,
            lineLimit: lineLimit,
            alignement: alignement
        )
    }
}


struct BodyMediumText:View {
    
    let text:String
    var fontFamily: String = Fonts.urbanistMedium
    var fontSize: CGFloat = 16
    var textColor: Color = Theme.onBackground
    var alignement:TextAlignment = .leading
    
    var body: some View {
        CommonText(
            text: text,
            fontFamily: fontFamily,
            fontSize: fontSize,
            textColor: textColor,
            alignement: alignement
        )
    }
}

struct BodySmallText:View {
    
    let text:String
    var fontFamily: String = Fonts.urbanistRegular
    var fontSize: CGFloat = 16
    var textColor: Color = Theme.onBackground
    var alignement:TextAlignment = .leading
    
    var body: some View {
        CommonText(
            text: text,
            fontFamily: fontFamily,
            fontSize: fontSize,
            textColor: textColor,
            alignement: alignement
        )
    }
}

struct BodyLargeText:View {
    
    let text:String
    var fontFamily: String = Fonts.urbanistSemiBold
    var fontSize: CGFloat = 16
    var textColor: Color = Theme.onBackground
    var alignement:TextAlignment = .leading
    
    var body: some View {
        CommonText(
            text: text,
            fontFamily: fontFamily,
            fontSize: fontSize,
            textColor: textColor,
            alignement: alignement
        )
    }
}

#Preview {
    Group{
        CommonText(text: "appname")
        BodyMediumText(text: "appname")
        BodyLargeText(text: "appname")
        TitleLarge(text: "appname")
        TitleMedium(text: "appname")
        TitleSmall(text: "appname")
    }
    .background(.white)

}
