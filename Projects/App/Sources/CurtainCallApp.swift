//
//  CurtainCallApp.swift
//  App
//
//  Created by 김민석 on 1/12/24.
//

import SwiftUI
import Common

@main
struct CurtainCallApp: App {
    @StateObject var appRootManager: AppRootManager = AppRootManager()
    var body: some Scene {
        WindowGroup {
            switch appRootManager.currentRoot {
            case .splash:
                SplashView()
            case .onboarding:
                Text("온보딩")
            case .login:
                Text("로그인")
            case .main:
                Text("메인")
            }
        }
        .environmentObject(appRootManager)
    }
}
