//
//  ProfileView.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import SwiftUI

import Common

import ComposableArchitecture

struct ProfileView: View {
    
    private let store: StoreOf<ProfileFeature>
    
    @Environment(\.dismiss) var dismiss
    
    init(store: StoreOf<ProfileFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            
        }
        .onAppear {
            store.send(.fetchUserInfo)
        }
        .navigationTitle("프로필 변경")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(asset: CommonAsset.navigationBackIcon)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

