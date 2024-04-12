//
//  ShowView.swift
//  Show
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import Common
import Review

import ComposableArchitecture
import NukeUI

public struct ShowView: View {
    @Bindable private var store: StoreOf<ShowFeature>
    
    public init(store: StoreOf<ShowFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: self.$store.scope(state: \.path, action: \.path)) {
            VStack {
                topbar
                Spacer().frame(height: 20)
                HStack(spacing: 8) {
                    makeShowTypeButton(type: .theater)
                        .onTapGesture {
                            store.send(.didTappedShowType(.theater))
                        }
                    makeShowTypeButton(type: .musical)
                        .onTapGesture {
                            store.send(.didTappedShowType(.musical))
                        }
                    Spacer()
                    categoryButton
                        .onTapGesture {
                            store.send(.didTappedCategory)
                        }
                }
                .padding(.horizontal, 20)
                ZStack {
                    if store.isShowTooltip {
                        tooltipView
                    }
                }
                .padding(.trailing, 28)
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
                                    .onAppear {
                                        if show == store.showList.last {
                                            store.send(.didScrollToLastItem)
                                        }
                                    }
                                    .onTapGesture {
                                        store.send(.didTappedShow(showId: show.id))
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
                    .padding(.horizontal, 20)
                    .padding(.top, 17)
                }
            }
            .onAppear {
                store.send(.fetchShowList(page: 0))
            }
            .sheet(store: self.store.scope(state: \.$bottomSheet, action: \.bottomSheet)) { store in
                ShowSortBottomSheet(store: store)
                    .presentationDetents([.height(270)])
                    .presentationDragIndicator(.visible)
            }
        } destination: { store in
            switch store.state {
            case .showSearch:
                if let store = store.scope(state: \.showSearch, action: \.showSearch) {
                    ShowSearchView(store: store)
                }
            case .showDetail:
                if let store = store.scope(state: \.showDetail, action: \.showDetail) {
                    ShowDetailView(store: store)
                }
            case .reviewWrite:
                if let store = store.scope(state: \.reviewWrite, action: \.reviewWrite) {
                    ReviewWriteView(store: store)
                }
            case .reviewList:
                if let store = store.scope(state: \.reviewList, action: \.reviewList) {
                    ReviewListView(store: store)
                }
            }
            
        }
        
    }
    
    private var topbar: some View {
        HStack {
            Text("작품")
                .font(.heading2)
                .padding(.leading, 20)
                .padding(.vertical, 8)
            Spacer()
            Image(asset: CommonAsset.navigationSearchIcon)
                .padding(.vertical, 10)
                .padding(.trailing, 16)
                .onTapGesture {
                    store.send(.didTappedSearch)
                }
        }
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
    
    private var tooltipView: some View {
        HStack {
            Spacer()
            HStack(spacing: 9) {
                Text("인기순은 현재 상영 중인 작품 50개만 볼 수 있어요!")
                    .font(.body4)
                    .foregroundStyle(.white)
                    .offset(y: 2.5)
                Image(asset: CommonAsset.xmarksWhite16px)
                    .foregroundStyle(.white)
                    .frame(width: 16, height: 16)
                    .offset(y: 2.5)
                    .onTapGesture {
                        store.send(.dismissTooltip)
                    }
            }
            .background(
                Image(asset: CommonAsset.showTooltipView)
            )
        }
    }
}
