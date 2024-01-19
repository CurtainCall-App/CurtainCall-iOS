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
            VStack {
                HStack {
                    Text("애플로그인")
                        .onTapGesture {
                            store.send(.appleLoginTapped)
                        }
                    Text("카카오로그인")
                        .onTapGesture {
                            store.send(.kakaoLoginTapped)
                        }
                    Text("네이버로그인")
                        .onTapGesture {
                            store.send(.naverLoginTapped)
                        }
                }
            }
        }
    }
}
