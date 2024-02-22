//
//  CurtainCallApp.swift
//  App
//
//  Created by 김민석 on 1/12/24.
//

import SwiftUI
import Common
import Login
import Main

import ComposableArchitecture
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin

@main
struct CurtainCallApp: App {
    
    @StateObject var appRootManager: AppRootManager = AppRootManager()
    
    init() {
        NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
        initKakaoLoginSDK()
        initNaverLoginSDK()
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
                        AuthController.handleOpenUrl(url: url)
                    } else {
                        NaverThirdPartyLoginConnection.getSharedInstance().receiveAccessToken(url)
                    }
                })
            case .main:
                MainView()
            }
        }
        .environmentObject(appRootManager)
    }
    
    func initKakaoLoginSDK() {
        KakaoSDK.initSDK(appKey: Secret.KAKAO_NATIVE_APP_KEY)
    }
    
    func initNaverLoginSDK() {
        NaverThirdPartyLoginConnection.getSharedInstance().isNaverAppOauthEnable = true
        NaverThirdPartyLoginConnection.getSharedInstance().isInAppOauthEnable = true
        
        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
        
        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = Secret.NAVER_LOGIN_SCHEME
        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = Secret.NAVER_APP_KEY
        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = Secret.NAVER_APP_SECRET
        NaverThirdPartyLoginConnection.getSharedInstance().appName = "커튼콜"
    }
}
