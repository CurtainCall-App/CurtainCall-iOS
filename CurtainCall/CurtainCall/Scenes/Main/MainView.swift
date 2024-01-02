//
//  MainView.swift
//  CurtainCall
//
//  Created by 김민석 on 1/2/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var isSplash: Bool = true
    
    var body: some View {
        ZStack {
            if !UserDefaults.standard[.isNotFirstUser] {
                OnboardingView()
                    .onDisappear {
                        UserDefaults.standard[.isNotFirstUser] = true
                    }
            }
            
            if let accessToken = UserDefaults.standard[.accessToken] {
                //TODO: 메인 화면으로
                Text("메인")
            } else {
                //TODO: 로그인 화면으로
                Text("로그인")
            }
            if isSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.isSplash = false
                        }
                    }
            }
            
            
            
//
        }
        
    }
}

