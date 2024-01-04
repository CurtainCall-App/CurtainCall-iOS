//
//  SplashView.swift
//  CurtainCall
//
//  Created by 김민석 on 12/28/23.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appRootManager: AppRootManager
    @State var isAnimation = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.pointColor1
            VStack {
                Spacer()
                Image(ImageNamespace.splashLogo)
                    .opacity(isAnimation ? 0 : 1)
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.easeIn(duration: 2.0)) {
                isAnimation.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                appRootManager.changeFirstRoot()
            }
        }
        .ignoresSafeArea()
    }
}
