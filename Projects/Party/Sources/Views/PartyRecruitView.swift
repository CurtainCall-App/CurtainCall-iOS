//
//  PartyRecruitView.swift
//  Party
//
//  Created by 김민석 on 4/11/24.
//

import SwiftUI

import Common
import Show

import NukeUI
import ComposableArchitecture

public struct PartyRecruitView: View {
    
    @Bindable private var store: StoreOf<PartyRecruitFeature>
    
    @Environment (\.dismiss) var dismiss
    
    public init(store: StoreOf<PartyRecruitFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            topView
            switch store.viewType {
            case .step1: step1.onAppear { store.send(.fetchShowList(page: 0)) }
            case .step2: step2
            case .step3: step3
            }
        }
        .toolbar(.hidden)
        
    }
    
    private var topView: some View {
        HStack {
            Image(asset: CommonAsset.navigationBackIcon)
                .onTapGestureRectangle {
                    dismiss()
                }
            Spacer()
            Text("파티원 모집")
                .font(.subTitle3)
                .foregroundStyle(.black)
            Spacer()
            Image(asset: CommonAsset.navigationSearchIcon)
                
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
    
    private func makeShowTypeButton(type: ShowFeature.ShowType) -> some View {
        Text(type.title)
            .font(.body2_SB)
            .foregroundStyle(store.selectedShowType == type ? Color.white : Color.gray6)
            .padding(.horizontal, 11)
            .padding(.vertical, 4)
            .background(store.selectedShowType == type ? Color.primary1 : Color.gray9)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .onTapGestureRectangle {
                store.send(.didTappedShowTypeButton(type))
            }
    }
    
    private var categoryButton: some View {
        HStack(spacing: 2) {
            Text(store.selectedCategory.title)
                .font(.body3)
            Image(asset: CommonAsset.arrowTriangleDownFill)
        }
        .onTapGestureRectangle {
            store.send(.didTappedCategoryButton)
        }
    }
    
    private var nextButton: some View {
        VStack {
            Spacer()
            RectangleBottomButton(isEnable: $store.isPossibleNextButton, text: store.viewType != .step3 ? "다음" : "작성 완료") {
                store.send(.didTappedNextButton)
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 20)
        }
    }
    
    @MainActor
    private var step1: some View {
        ZStack {
            VStack(spacing: 0) {
                Image(asset: CommonAsset.partyRecruitProgressStep1)
                    .padding(.top, 20)
                VStack(spacing: 0) {
                    HStack {
                        Text("작품을 선택해주세요")
                            .foregroundStyle(.black)
                            .font(.subTitle4)
                        Spacer()
                    }
                    .padding(.top, 30)
                    HStack {
                        makeShowTypeButton(type: .theater)
                        makeShowTypeButton(type: .musical)
                        Spacer()
                        categoryButton
                    }
                    .padding(.top, 12)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(store.showList, id: \.self) { show in
                                VStack(spacing: 6) {
                                    Spacer().frame(height: 10)
                                    LazyImage(url: URL(string: show.poster)) {
                                        state in
                                        if let image = state.image {
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } else if state.error != nil {
                                            ProgressView()
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: 105, height: 140)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 10)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.primary1, lineWidth: store.selectedShow == show ? 3 : 0)
                                        )
                                    
                                    
                                    Text(show.name)
                                        .font(.body3_SB)
                                        .foregroundStyle(.black)
                                        .lineLimit(1)
                                }
                                .onTapGestureRectangle {
                                    store.send(.didTappedShowItem(show))
                                }
                                .onAppear {
                                    if show == store.showList.last {
                                        store.send(.didScrollToLastItem)
                                    }
                                }
                                
                            }
                        }
                        Color.clear.frame(height: 70)
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            nextButton
        }
        .sheet(item: $store.scope(state: \.bottomSheet, action: \.bottomSheet)) { store in
            ShowSortBottomSheet(store: store)
                .presentationDetents([.height(270)])
                .presentationDragIndicator(.visible)
        }
    }
    
    private var step2: some View {
        VStack {
            Color.yellow
            Spacer()
        }
    }
    private var step3: some View {
        VStack {
            Color.green
            Spacer()
        }
    }
    
}
