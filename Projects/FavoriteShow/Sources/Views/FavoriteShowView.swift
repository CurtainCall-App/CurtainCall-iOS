//
//  FavoriteShowView.swift
//  FavoriteShow
//
//  Created by 김민석 on 12/8/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct FavoriteShowView: View {
    @Bindable private var store: StoreOf<FavoriteShowFeature>
    
    @Environment(\.dismiss) var dismiss
    
    public init(store: StoreOf<FavoriteShowFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("")
            .navigationTitle("좋아요한 작품")
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
