//
//  ShowSearchView.swift
//  Show
//
//  Created by 김민석 on 3/1/24.
//

import SwiftUI

import Common

import ComposableArchitecture
import NukeUI

public struct ShowSearchView: View {
    @Bindable private var store: StoreOf<ShowSearchFeature>
    
    public init(store: StoreOf<ShowSearchFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            HStack {
                TextField("작품 제목을 입력하세요.", text: $store.showTitleText)
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
                        store.send(.didTappedCancelButton)
                    }
            }
            .frame(height: 44)
            Spacer().frame(height: 30)
            if store.showTitleText.isEmpty {
                HStack {
                    Text("최근 검색어")
                        .font(.body2_SB)
                        .foregroundStyle(.black)
                    Spacer()
                    if !store.recentSearches.isEmpty {
                        Text("전체 삭제")
                            .font(.body2_SB)
                            .foregroundStyle(Color.gray6)
                            .onTapGesture {
                                store.send(.didTappedAllRemoveRecentSearches)
                            }
                    }
                }
                Spacer().frame(height: 20)
                if !store.recentSearches.isEmpty {
                    VStack(spacing: 24) {
                        ForEach(0..<store.recentSearches.count, id: \.self) { index in
                            makeRecentSearchesItem(title: store.recentSearches[index], index: index)
                                .onTapGesture {
                                    store.send(.didTappedRecentSearches(title: store.recentSearches[index]))
                                }
                        }
                        Spacer()
                    }
                } else {
                    emptyView
                }
                Spacer()
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(store.showList, id: \.self) { show in
                            VStack(spacing: 10) {
                                ZStack(alignment: .bottom) {
                                    LazyImage(url: URL(string: show.poster)) { state in
                                        if let image = state.image {
                                            image.resizable().aspectRatio(contentMode: .fill)
                                        } else if state.error != nil {
                                            // TODO: 에러처리
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: 160, height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .onTapGesture {
                                        store.send(.didTappedShow(show: show))
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        Image(asset: CommonAsset.showFavoriteUnfill)
                                            .frame(width: 28, height: 28)
                                    }
                                    .padding([.bottom, .trailing], 10)
                                }
                                Text(show.name)
                                    .font(.body2_SB)
                                    .lineLimit(1)
                                Spacer().frame(height: 20)
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                }
            }
            
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden()
    }
    
    private var emptyView: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(asset: CommonAsset.showSearchEmptyListIcon60px)
            Text("검색 내역이 없어요")
                .font(.body2_SB)
                .foregroundStyle(Color.primary1)
            Spacer()
        }
    }
    
    private func makeRecentSearchesItem(title: String, index: Int) -> some View {
        HStack {
            HStack {
                Text("\(title)")
                    .font(.body3_SB)
                    .foregroundStyle(Color.gray2)
                    .padding(.leading, 12)
                    .lineLimit(1)
                Spacer().frame(width: 8)
                Image(asset: CommonAsset.iconSearchClose)
                    .padding(.trailing, 12)
                    .onTapGesture {
                        store.send(.didTappedRemoveRecentSearches(index: index))
                    }
            }
            .background(
                Capsule(style: .circular)
                    .foregroundStyle(Color.gray9)
                    .frame(height: 32)
            )
            Spacer()
        }
    }
}
