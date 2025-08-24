//
//  SplashView.swift
//  CoinRanker
//
//  Created by Felix kariuki on 30/07/2025.
//

import SwiftUI

struct SplashView: View {
    
    @State private var finished       = false
    @State private var logoScale      = 0.4
    @State private var logoOpacity    = 0.0
    @State private var textReveal     = false
    @State private var rippleScale    = 1.0
    @State private var overlayOpacity = 0.0
    
    var body: some View {
        ZStack {
            Theme.primaryColor.ignoresSafeArea()
            
            Theme.primaryColor
                .opacity(overlayOpacity)
                .scaleEffect(rippleScale)
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                
                Image("btc")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .shadow(color: .black.opacity(0.25),
                            radius: 8, x: 0, y: 4)
                
                if textReveal { brandText }
            }
            
        }
        .onAppear{
            sequence()
        }
        .fullScreenCover(isPresented: $finished){
            CoinsViews()
        }
    }
    
    private var brandText: some View {
        HStack(spacing: 0) {
            Text("CoinPulse")
                .foregroundColor(.white)
        }
        .font(.system(size: 42, weight: .heavy))
        .mask(
            Rectangle()
                .offset(x: textReveal ? 0 : -250)
                .animation(.easeOut(duration: 0.6),
                           value: textReveal)
        )
    }
    
    private func sequence() {
        
        withAnimation(.spring(response: 0.55,
                              dampingFraction: 0.6)) {
            logoScale   = 1.0
            logoOpacity = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            textReveal = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            withAnimation(.easeInOut(duration: 0.4)) {
                rippleScale    = 0.02
                overlayOpacity = 1.0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            finished = true
        }
    }
}

#Preview {
    SplashView()
}
