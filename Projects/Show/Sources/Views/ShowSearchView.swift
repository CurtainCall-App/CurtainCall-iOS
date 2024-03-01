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
                Spacer().frame(height: 30)
                if viewStore.showTitleText.isEmpty {
                    HStack {
                        Text("최근 검색어")
                            .font(.body2_SB)
                            .foregroundStyle(.black)
                        Spacer()
                        Text("전체 삭제")
                            .font(.body2_SB)
                            .foregroundStyle(Color.gray6)
                    }
                    Spacer().frame(height: 20)
                    VStack(spacing: 24) {
                        ForEach(0..<viewStore.recentSearches.count, id: \.self) { index in
                            makeRecentSearchesItem(title: viewStore.recentSearches[index], index: index)
                        }
                        Spacer()
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(1...5, id: \.self) { _ in
//                            ForEach(viewStore.showList, id: \.self) { show in
                                VStack(spacing: 10) {
                                    ZStack(alignment: .bottom) {
//                                        LazyImage(url: URL(string: show.poster)) { state in
//                                            if let image = state.image {
//                                                image.resizable().aspectRatio(contentMode: .fill)
//                                            } else if state.error != nil {
//                                                // TODO: 에러처리
//                                            } else {
//                                                ProgressView()
//                                            }
//                                        }
                                        Color.red
                                        .frame(width: 160, height: 250)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .onAppear {
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            Image(asset: CommonAsset.showFavoriteUnfill)
                                                .frame(width: 28, height: 28)
                                        }
                                        .padding([.bottom, .trailing], 10)
                                    }
                                    Text("작품명")
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
        }
        .navigationBarBackButtonHidden()
    }
    
    private func makeRecentSearchesItem(title: String, index: Int) -> some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
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
                            viewStore.send(.didTappedRemoveRecentSearches(index: index))
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
}