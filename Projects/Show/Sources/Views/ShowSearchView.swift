//
//  ShowSearchView.swift
//  Show
//
//  Created by 김민석 on 3/1/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct ShowSearchView: View {
    private let store: StoreOf<ShowSearchFeature>
    
    public init(store: StoreOf<ShowSearchFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    TextField("작품 제목을 입력하세요.", text: viewStore.$showTitleText)
                        .font(.body2_SB)
                        .foregroundStyle(.black)
                        .padding(.leading, 14)
                        .background {
                            Capsule(style: .circular)
                                .foregroundStyle(Color.gray9)
                                .frame(height: 44)
                        }
                    Text("취소")
                        .onTapGesture {
                            viewStore.send(.didTappedCancelButton)
                        }
                }
                .frame(height: 44)
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden()
    }
}
