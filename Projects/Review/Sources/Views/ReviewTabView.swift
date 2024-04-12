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
        VStack {
            if store.reviewList.isEmpty {
                emptyView
            } else {
                reviewView
            }
        }
        .onAppear {
            store.send(.fetchReviewList(sort: .createdAt))
        }
    }
    
    public var reviewView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(store.reviewList.count)개의 리뷰가 있어요")
                .font(.subTitle3)
                .foregroundStyle(.black)
                .padding(.top, 28)
            VStack(spacing: 12) {
                ForEach(store.reviewList.prefix(3), id: \.self) { review in
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            makeGradeView(grade: review.grade)
                                .padding(.top, 12)
                            Spacer()
                        }
                        HStack {
                            Text(review.content)
                                .font(.body3)
                                .padding(.top, 10)
                                .foregroundStyle(.black)
                                .lineLimit(1)
                            Spacer()
                        }
                        HStack {
                            Text("\(review.creatorNickname) | \(review.createdAt ?? "")")
                                .font(.body3_SB)
                                .padding(.vertical, 10)
                                .foregroundStyle(Color.gray6)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 12)
                }
                
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.08) ,radius: 10, y: 2)
            }
            
            
            Text("리뷰 모두 보기")
                .font(.subTitle4)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.primary1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 28)
                .padding(.bottom, 10)
                .onTapGestureRectangle {
                    store.send(.didTappedReviewList(showInfo: store.showInfo))
                }
        }
        .padding(.horizontal, 20)
        
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
                .onTapGestureRectangle {
                    store.send(.didTappedReviewWriteButton(store.showInfo))
                }
        }
        .padding(.horizontal, 20)
        
    }
    
    private func makeGradeView(grade: Int) -> some View {
        HStack(spacing: 1) {
            ForEach(0..<grade, id: \.self) {
                _ in
                Image(asset: CommonAsset.reviewWriteGradeStartFill16px)
            }
            ForEach(0..<5 - grade, id: \.self) {
                _ in
                Image(asset: CommonAsset.reviewWriteGradeStartUnfill16px)
            }
        }
    }
}
