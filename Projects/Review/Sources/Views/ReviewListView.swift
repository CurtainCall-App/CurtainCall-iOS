//
//  ReviewListView.swift
//  Review
//
//  Created by 김민석 on 3/24/24.
//

import SwiftUI

import Common
import ComposableArchitecture

public struct ReviewListView: View {
    
    @Environment(\.dismiss) var dismiss
    private let store: StoreOf<ReviewListFeature>
    
    public init(store: StoreOf<ReviewListFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.gray8.ignoresSafeArea()
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("\(viewStore.reviewList.count)개의 리뷰가 있어요")
                                    .font(.subTitle4)
                                    .foregroundStyle(Color.primary1)
                                Spacer()
                                categoryButton
                            }
                            .padding(.top, 24)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 16)
                            ForEach(viewStore.reviewList, id: \.id) { review in
                                VStack(alignment: .leading) {
                                    makeProfileView(
                                        profileImageURL: "",
                                        name: review.creatorNickname,
                                        date: review.createdAt ?? ""
                                    )
                                    makeGradeView(grade: review.grade)
                                        .padding(.top, 10)
                                        .padding(.horizontal, 20)
                                    
                                    Text(review.content)
                                        .font(.body2_M)
                                        .foregroundStyle(Color.gray3)
                                        .padding(.top, 10)
                                        .padding(.horizontal, 20)
                                    HStack(spacing: 6) {
                                        Image(asset: CommonAsset.iconThumbUpDeselected16px)
                                            .padding(.leading, 8)
                                            .padding(.vertical, 4)
                                        Text("\(review.likeCount ?? 0)")
                                            .font(.body4)
                                            .foregroundStyle(Color.gray6)
                                            .padding(.trailing, 8)
                                            .padding(.vertical, 3)
                                    }
                                    .background(Color.gray8)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .padding(.top, 10)
                                    .padding(.horizontal, 20)
                                }
                                
                                Color.gray8.frame(height: 10)
                                    .padding(.top, 20)
                            }
                        }
                    }
                    VStack {
                        Spacer()
                        
                        createButton
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                        
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationTitle("공연 리뷰")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(asset: CommonAsset.navigationBackIcon)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
                .onAppear {
                    viewStore.send(.fetchReviewList)
                }
            }
        }
        
    }
    
    private var categoryButton: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 2) {
                Text(viewStore.selectedCategory.title)
                    .font(.body3)
                Image(asset: CommonAsset.arrowTriangleDownFill)
            }
        }
    }
    
    private func makeProfileView(
        profileImageURL: String,
        name: String,
        date: String
    ) -> some View {
        HStack(spacing: 12) {
            Color.gray7
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(name)
                    .font(.body3_SB)
                    .foregroundStyle(.black)
                Text(date)
                    .font(.body3_SB)
                    .foregroundStyle(Color.gray5)
            }
            Spacer()
            Image(asset: CommonAsset.iconMore24px)
        }
        .padding(.top, 20)
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
    
    private var createButton: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("리뷰 작성하기")
                .font(.subTitle4)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.primary1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGestureRectangle {
                    viewStore.send(.didTappedCreateReview(showInfo: viewStore.showInfo))
                }
        }
        
    }
}


