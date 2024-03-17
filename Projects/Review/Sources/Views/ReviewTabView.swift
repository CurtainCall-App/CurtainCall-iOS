//
//  ReviewTabView.swift
//  Review
//
//  Created by 김민석 on 3/16/24.
//

import SwiftUI

import Common
import ComposableArchitecture

public struct ReviewTabView: View {
    
    private let store: StoreOf<ReviewFeature>
    
    public init(store: StoreOf<ReviewFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                if viewStore.reviewList.isEmpty {
                    emptyView
                } else {
                    reviewView
                }
            }
            .onAppear {
                viewStore.send(.fetchReviewList(sort: .createdAt))
            }
        }
    }
    
    public var reviewView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 12) {
                Text("\(viewStore.reviewList.count)개의 리뷰가 있어요")
                    .font(.subTitle3)
                    .foregroundStyle(.black)
                    .padding(.top, 28)
                Text("리뷰 모두 보기")
                    .font(.subTitle4)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.primary1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 28)
                    .padding(.bottom, 10)
            }
            .padding(.horizontal, 20)
        }
    }
    
    public var emptyView: some View {
        VStack {
            Image(asset: CommonAsset.emptyReviewIcon)
                .padding(.top, 60)
            Text("아직 리뷰가 없어요")
                .font(.body2_SB)
                .foregroundStyle(Color.primary1)
                .padding(.top, 16)
            Text("리뷰 작성하기")
                .font(.subTitle4)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.primary1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 60)
                .padding(.bottom, 10)
        }
        .padding(.horizontal, 20)
    }
}
