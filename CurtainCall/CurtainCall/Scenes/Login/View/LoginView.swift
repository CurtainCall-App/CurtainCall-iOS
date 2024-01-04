//
//  LoginView.swift
//  CurtainCall
//
//  Created by 김민석 on 1/2/24.
//

import SwiftUI
import AuthenticationServices

import ComposableArchitecture

struct LoginView: View {
    let store: StoreOf<LoginFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Spacer()
                HStack {
                    Image(ImageNamespace.loginButtonApple)
                        .onTapGesture {
                            viewStore.send(.appleLoginTapped)
                        }
                    Image(ImageNamespace.loginButtonKakao)
                    
                }
                Spacer()
            }
        }
    }
}


