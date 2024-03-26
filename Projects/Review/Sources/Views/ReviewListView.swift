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
            Color.gray9.ignoresSafeArea()
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("1021개의 리뷰가 있어요")
                                    .font(.subTitle4)
                                    .foregroundStyle(Color.primary1)
                                Spacer()
                                categoryButton
                            }
                            .padding(.top, 24)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 16)
                            profileView
                            
                            makeGradeView(grade: 5)
                                .padding(.top, 20)
                                .padding(.horizontal, 20)
                            
                            Text("고전연극은처음인데엄청재미있게봤어요고전연극은처음인데엄청재미있게봤어요고전연극은처음인데엄청재미있게봤어요고전연극은처음인데엄청재미있게봤어요고전...")
                                .font(.body2_M)
                                .foregroundStyle(Color.gray3)
                                .padding(.top, 10)
                                .padding(.horizontal, 20)
                            HStack(spacing: 6) {
                                Image(asset: CommonAsset.iconThumbUpDeselected16px)
                                    .padding(.leading, 8)
                                    .padding(.vertical, 4)
                                Text("16")
                                    .font(.body4)
                                    .foregroundStyle(Color.gray6)
                                    .padding(.trailing, 8)
                                    .padding(.vertical, 3)
                            }
                            .background(Color.gray8)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .padding(.top, 10)
                            .padding(.horizontal, 20)
                            
                            Color.gray9.frame(height: 10)
                                .padding(.top, 20)
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
            }
        }

    }
    
    private var categoryButton: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 2) {
//                Text(viewStore.selectedCategory.title)
                Text("인기순")
                    .font(.body3)
                Image(asset: CommonAsset.arrowTriangleDownFill)
            }
        }
    }
    
    private var profileView: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                Color.gray7
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("만도스스스스슥")
                        .font(.body3_SB)
                        .foregroundStyle(.black)
                    Text("2023.06.28")
                        .font(.body3_SB)
                        .foregroundStyle(Color.gray5)
                }
                Spacer()
                Image(asset: CommonAsset.iconMore24px)
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
        }
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
        Text("리뷰 작성하기")
            .font(.subTitle4)
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.primary1)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


