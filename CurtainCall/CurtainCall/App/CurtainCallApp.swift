//
//  CurtainCallApp.swift
//  CurtainCall
//
//  Created by 김민석 on 1/4/24.
//

import SwiftUI

@main
struct CurtainCallApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appRootManager: AppRootManager = AppRootManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .onboarding:
                    OnboardingView()
                case .splash:
                    SplashView()
                case .login:
                    LoginView()
                case .main:
                    MainView()
                }
            }
            .environmentObject(appRootManager)
        }
    }
}
