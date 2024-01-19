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
                Text("메인")
            }
        }
        .environmentObject(appRootManager)
    }
    
    func initKakaoLoginSDK() {
        if let kakaoAppKey = BundleKeyValue.KAKAO_NATIVE_APP_KEY.stringValue {
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        } else {
            print("⚠️ [ERROR]: 카카오 앱 키 가져올 수 없음")
        }
    }
    
    func initNaverLoginSDK() {
        NaverThirdPartyLoginConnection.getSharedInstance().isNaverAppOauthEnable = true
        NaverThirdPartyLoginConnection.getSharedInstance().isInAppOauthEnable = true
        
        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
        
        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = ""
        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = "DjNLGenMdpRgoAcodTfx"
        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = "FHmWzw6H8F"
        NaverThirdPartyLoginConnection.getSharedInstance().appName = "커튼콜"
    }
}
