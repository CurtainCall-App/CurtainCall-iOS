//
//  FAQView.swift
//  MyPage
//
//  Created by 김민석 on 6/2/24.
//

import SwiftUI

import Common

import ComposableArchitecture

struct FAQView: View {
    
    private let store: StoreOf<FAQFeature>
    
    @Environment(\.dismiss) var dismiss
    
    init(store: StoreOf<FAQFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    Spacer().frame(width: 20)
                    ForEach(FAQFeature.FAQType.allCases, id: \.rawValue) { type in
                        makeCategoryItem(type: type)
                            .onTapGestureRectangle {
                                store.send(.didTappedType(type))
                            }
                    }
                }
            }
            .padding(.top, 20)
            .scrollIndicators(.hidden)
            
            makeFAQList(type: store.faqType)
            
            Spacer()
        }
        .navigationTitle("자주 묻는 질문")
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
    
    private func makeCategoryItem(type: FAQFeature.FAQType) -> some View {
        Text(type.rawValue)
            .font(.body2_SB)
            .foregroundStyle(store.faqType == type ? Color.white : Color.gray6)
            .padding(.horizontal, 11)
            .padding(.vertical, 4)
            .background(store.faqType == type ? Color.primary1 : Color.gray8)
            .clipShape(Capsule())
    }
    
    private func makeFAQList(type: FAQFeature.FAQType) -> some View {
        ScrollView {
            ForEach(Array(zip(type.list.indices, type.list)), id: \.0) { index, item in
                VStack {
                    HStack {
                        Text(item.title)
                            .font(.body2_SB)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(asset: store.isOpened[index] ? CommonAsset.arrowUpIcon16px : CommonAsset.arrowDownIcon16px)
                    }
                    .padding(20)
                    .onTapGestureRectangle {
                        store.send(.didTappedOpen(index))
                    }
                    if store.isOpened[index] {
                        HStack {
                            Text(item.description)
                                .font(.body3)
                                .foregroundStyle(Color.gray2)
                                .padding(20)
                            Spacer()
                        }
                        .background(Color.gray9)
                    } else {
                        Color.gray8.frame(height: 1)
                            .padding(.horizontal, 20)
                    }
                }
                
            }
        }
    }
}
