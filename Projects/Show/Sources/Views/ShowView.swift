//
//  ShowView.swift
//  Show
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct ShowView: View {
    private let store: StoreOf<ShowFeature>
    
    public init(store: StoreOf<ShowFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                topbar
                Spacer().frame(height: 20)
                HStack(spacing: 8) {
                    makeCategoryButton(type: .theater)
                        .onTapGesture {
                            viewStore.send(.didTappedShowType(.theater))
                        }
                    makeCategoryButton(type: .musical)
                        .onTapGesture {
                            viewStore.send(.didTappedShowType(.musical))
                        }
                    Spacer()
                }
                .padding(.horizontal, 20)
                Spacer()
            }
        }
    }
    
    private var topbar: some View {
        HStack {
            Text("작품")
                .font(.heading2)
                .padding(.leading, 20)
                .padding(.vertical, 8)
            Spacer()
            Image(asset: CommonAsset.navigationSearchIcon)
                .padding(.vertical, 10)
                .padding(.trailing, 16)
        }
        .frame(height: 44)
    }
    
    private func makeCategoryButton(type: ShowFeature.ShowType) -> some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text(type.title)
                .font(.body2_SB)
                .foregroundStyle(viewStore.selectedShowType == type ? Color.white : Color.gray6)
                .padding(.horizontal, 11)
                .padding(.vertical, 4)
                .background(viewStore.selectedShowType == type ? Color.primary1 : Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        
    }
}
