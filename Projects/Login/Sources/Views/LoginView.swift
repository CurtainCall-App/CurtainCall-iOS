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
    private let store: StoreOf<LoginFeature>
    
    @EnvironmentObject var appRootManager: AppRootManager
    
    public init(store: StoreOf<LoginFeature>) {
        self.store = store
    }
    @State var isNext: Bool = false
    public var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
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
                                .onTapGesture { viewStore.send(.kakaoLoginTapped) }
                            Image(asset: CommonAsset.loginNaver)
                                .onTapGesture { viewStore.send(.naverLoginTapped) }
                            Image(asset: CommonAsset.loginApple)
                                .onTapGesture { viewStore.send(.appleLoginTapped) }
                        }
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Text("로그인 없이 시작하기")
                                .font(.body2_SB)
                                .underline()
                                .foregroundStyle(.white)
                                .onTapGesture {
                                    appRootManager.currentRoot = .main
                                }
                            Spacer()
                        }
                        
                        Spacer().frame(height: 100)
                    }
                }
            }
        } destination: {
            switch $0 {
            case .termsOfService:
                CaseLet(
                    \LoginFeature.Path.State.termsOfService,
                     action: LoginFeature.Path.Action.termsOfService,
                     then: TermsOfServiceView.init(store:)
                    )
            
            case .nicknameSetting:
                CaseLet(
                    \LoginFeature.Path.State.nicknameSetting,
                     action: LoginFeature.Path.Action.nicknameSetting,
                     then: NicknameSettingView.init(store:)
                    )
            }
        }
    }
}
