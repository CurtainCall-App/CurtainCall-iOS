//
//  SplashView.swift
//  Common
//
//  Created by 김민석 on 1/12/24.
//

import SwiftUI

public struct SplashView: View {
    
    public init() { }
    
    @EnvironmentObject var appRootManager: AppRootManager
    @State private var isAnimation: Bool = false
    
    public var body: some View {
        ZStack {
            Image(asset: CommonAsset.logoSplash64px)
                .opacity(isAnimation ? 0 : 1)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 2.0)) {
                isAnimation.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                appRootManager.changeFirstView()
            }
        }
        .ignoresSafeArea()
    }
}
