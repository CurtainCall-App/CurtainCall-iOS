//
//  ShowView.swift
//  Show
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import Common

import ComposableArchitecture
import NukeUI

public struct ShowView: View {
    private let store: StoreOf<ShowFeature>
    
    public init(store: StoreOf<ShowFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                VStack {
                    topbar
                    Spacer().frame(height: 20)
                    HStack(spacing: 8) {
                        makeShowTypeButton(type: .theater)
                            .onTapGesture {
                                viewStore.send(.didTappedShowType(.theater))
                            }
                        makeShowTypeButton(type: .musical)
                            .onTapGesture {
                                viewStore.send(.didTappedShowType(.musical))
                            }
                        Spacer()
                        categoryButton
                            .onTapGesture {
                                viewStore.send(.didTappedCategory)
                            }
                    }
                    .padding(.horizontal, 20)
                    ZStack {
                        if viewStore.isShowTooltip {
                            tooltipView
                        }
                    }
                    .padding(.trailing, 28)
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(viewStore.showList, id: \.self) { show in
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
                                            if show == viewStore.showList.last {
                                                viewStore.send(.didScrollToLastItem)
                                            }
                                        }
                                        .onTapGesture {
                                            viewStore.send(.didTappedShow(showId: show.id))
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
                    viewStore.send(.fetchShowList(page: 0))
                }
            }
            .sheet(store: self.store.scope(state: \.$bottomSheet, action: \.bottomSheet)) { store in
                ShowSortBottomSheet(store: store)
                    .presentationDetents([.height(270)])
                    .presentationDragIndicator(.visible)
            }
        } destination: {
            switch $0 {
            case .showSearch:
                CaseLet(
                    \ShowFeature.Path.State.showSearch,
                     action: ShowFeature.Path.Action.showSeacrch,
                     then: ShowSearchView.init(store:)
                )
            case .showDetail:
                CaseLet(
                    \ShowFeature.Path.State.showDetail,
                     action: ShowFeature.Path.Action.showDetail,
                     then: ShowDetailView.init(store:)
                )
            }
            
        }
        
    }
    
    private var topbar: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
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
                        viewStore.send(.didTappedSearch)
                    }
            }
            .frame(height: 44)
        }
        
    }
    
    private func makeShowTypeButton(type: ShowFeature.ShowType) -> some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text(type.title)
                .font(.body2_SB)
                .foregroundStyle(viewStore.selectedShowType == type ? Color.white : Color.gray6)
                .padding(.horizontal, 11)
                .padding(.vertical, 4)
                .background(viewStore.selectedShowType == type ? Color.primary1 : Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 30))
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
    
    private var tooltipView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
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
                            viewStore.send(.dismissTooltip)
                        }
                }
                .background(
                    Image(asset: CommonAsset.showTooltipView)
                )
            }
        }
    }
}
