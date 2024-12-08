//
//  FavoriteShowView.swift
//  FavoriteShow
//
//  Created by 김민석 on 12/8/24.
//

import SwiftUI

import Common

import ComposableArchitecture
import NukeUI

public struct FavoriteShowView: View {
    @Bindable private var store: StoreOf<FavoriteShowFeature>
    
    @Environment(\.dismiss) var dismiss
    
    public init(store: StoreOf<FavoriteShowFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            
            topbar
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
                                    store.send(.didTappedShow(id: show.id))
                                }
                                
                                HStack {
                                    Spacer()
                                    Image(asset: CommonAsset.showFavoriteFill)
                                        .frame(width: 28, height: 28)
                                        .onTapGestureRectangle {
                                            store.send(.didTappedFavorite(id: show.id))
                                        }
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
                .padding(.horizontal, 20)
                .padding(.top, 17)
            }
            Spacer()
        }
            .navigationTitle("좋아요한 작품")
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
            .onAppear {
                store.send(.fetchFavoriteShowList)
            }
    }
    
    private var topbar: some View {
        VStack {
            Spacer().frame(height: 20)
            HStack(spacing: 8) {
                makeShowTypeButton(type: .theater)
                makeShowTypeButton(type: .musical)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Spacer().frame(height: 5)
        }
    }
    
    private func makeShowTypeButton(type: ShowType) -> some View {
        Text(type.title)
            .font(.body2_SB)
            .foregroundStyle(store.selectedShowType == type ? Color.white : Color.gray6)
            .padding(.horizontal, 11)
            .padding(.vertical, 4)
            .background(store.selectedShowType == type ? Color.primary1 : Color.gray9)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .onTapGesture {
                store.send(.didTappedShowType(type))
            }
    }
}
