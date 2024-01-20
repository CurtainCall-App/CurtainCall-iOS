//
//  LoginView.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/15/24.
//

import SwiftUI
import Common

import ComposableArchitecture

public struct LoginView: View {
    public let store: StoreOf<LoginFeature>
    
    public init(store: StoreOf<LoginFeature>) {
        self.store = store
    }
    
    public var body: some View {
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
                            .onTapGesture { store.send(.kakaoLoginTapped) }
                        Image(asset: CommonAsset.loginNaver)
                            .onTapGesture { store.send(.naverLoginTapped) }
                        Image(asset: CommonAsset.loginApple)
                            .onTapGesture { store.send(.appleLoginTapped) }
                    }
                    Spacer()
                    Text("로그인 없이 시작하기")
                        .font(.body2_SB)
                        .underline()
                        .foregroundStyle(.white)
                        
                    Spacer().frame(height: 100)
                }
            }
        }
    }
}
