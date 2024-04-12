//
//  ShowSortBottomSheet.swift
//  Show
//
//  Created by 김민석 on 2/25/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct ShowSortBottomSheet: View {
    private let store: StoreOf<ShowSortFeature>
    
    public init(store: StoreOf<ShowSortFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Spacer()
            .frame(height: 36)
            ForEach(ShowSortFeature.CategoryType.allCases, id: \.self) { type in
                HStack {
                    Text(type.title)
                        .font(.body2_SB)
                        .foregroundStyle(store.categoryType == type ? Color.primary1 : Color.gray5)
                    Spacer()
                    if store.categoryType == type {
                        Image(asset: CommonAsset.iconCheckmarkPrimary2)
                    }
                }
                .frame(height: 50)
                .onTapGestureRectangle {
                    store.send(.didTappedCategory(type))
                }
            }
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}
