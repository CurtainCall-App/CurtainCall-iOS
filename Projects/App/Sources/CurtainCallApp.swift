//
//  CurtainCallApp.swift
//  App
//
//  Created by 김민석 on 1/12/24.
//

import SwiftUI
import Common
import Login

import ComposableArchitecture
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct CurtainCallApp: App {
    @StateObject var appRootManager: AppRootManager = AppRootManager()
    
    init() {
        if let kakaoAppKey = BundleKeyValue.KAKAO_NATIVE_APP_KEY.stringValue {
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        } else {
            print("⚠️ [ERROR]: 카카오 앱 키 가져올 수 없음")
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            switch appRootManager.currentRoot {
            case .splash:
                SplashView()
            case .onboarding:
                Text("온보딩")
            case .login:
                LoginView(
                    store: Store(initialState: LoginFeature.State()) {
                        LoginFeature()
                            ._printChanges()
                    }
                )
                .onOpenURL(perform: { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        print("가능 \(url)")
                        AuthController.handleOpenUrl(url: url)
                    } else {
                        print("불가")
                    }
                })
            case .main:
                Text("메인")
            }
        }
        .environmentObject(appRootManager)
    }
}
