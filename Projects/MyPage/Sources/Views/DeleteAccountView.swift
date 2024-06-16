//
//  DeleteAccountView.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import SwiftUI

import Common

import ComposableArchitecture

struct DeleteAccountView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let store: StoreOf<DeleteAccountFeature>
    
    init(store: StoreOf<DeleteAccountFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            
        }
        .navigationTitle("계정 삭제")
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
