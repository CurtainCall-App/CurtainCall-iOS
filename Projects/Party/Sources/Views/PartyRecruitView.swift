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
    
    private let store: StoreOf<PartyRecruitFeature>
    
    @Environment (\.dismiss) var dismiss
    
    public init(store: StoreOf<PartyRecruitFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            topView
            switch store.viewType {
            case .step1: step1.onAppear { store.send(.fetchShowList(page: 0)) }
            case .step2: EmptyView()
            case .step3: EmptyView()
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
    }
    
    private var categoryButton: some View {
        HStack(spacing: 2) {
            Text(store.selectedCategory.title)
                .font(.body3)
            Image(asset: CommonAsset.arrowTriangleDownFill)
        }
    }
    
    @MainActor
    private var step1: some View {
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
                                LazyImage(url: URL(string: show.poster)) {
                                    state in
                                    if let image = state.image {
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } else if state.error != nil {
                                        ProgressView()
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 105, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Text(show.name)
                                    .font(.body3_SB)
                                    .foregroundStyle(.black)
                                    .lineLimit(1)
                            }
                            .onAppear {
                                if show == store.showList.last {
                                    store.send(.didScrollToLastItem)
                                }
                            }
                            
                        }
                    }
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
    
}
