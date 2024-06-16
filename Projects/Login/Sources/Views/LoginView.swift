//
//  LoginView.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/15/24.
//

import SwiftUI
import Common
import TermsOfService
import NicknameSetting

import ComposableArchitecture

public struct LoginView: View {
    @Bindable private var store: StoreOf<LoginFeature>
    
    public init(store: StoreOf<LoginFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: self.$store.scope(state: \.path, action: \.path)) {
            ZStack {
                Color(asset: CommonAsset.hex0D1327)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image(asset: CommonAsset.logoSplash64px)
                    Spacer().frame(height: 74)
                    Image(asset: CommonAsset.loginComment)
                    Spacer().frame(height: 17)
                    HStack(spacing: 16) {
                        Image(asset: CommonAsset.loginKakaotalk)
                            .onTapGesture { store.send(.kakaoLoginTapped) }
                        Image(asset: CommonAsset.loginNaver)
                            .onTapGesture { store.send(.naverLoginTapped) }
                        Image(asset: CommonAsset.loginApple)
                            .onTapGesture { store.send(.appleLoginTapped) }
                    }
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("로그인 없이 시작하기")
                            .font(.body2_SB)
                            .underline()
                            .foregroundStyle(.white)
                            .onTapGesture {
                                AppRootManager.shared.currentRoot = .main
                            }
                        Spacer()
                    }
                    
                    Spacer().frame(height: 100)
                }
            }
            .onChange(of: store.appRootView) { _ , newValue in
                AppRootManager.shared.currentRoot = newValue
            }
        
            
        } destination: { store in
            switch store.state {
            case .termsOfService:
                if let store = store.scope(state: \.termsOfService, action: \.termsOfService) {
                    TermsOfServiceView(store: store)
                }
            case .nicknameSetting:
                if let store = store.scope(state: \.nicknameSetting, action: \.nicknameSetting) {
                    NicknameSettingView(store: store)
                }
            }
        }
    }
}
