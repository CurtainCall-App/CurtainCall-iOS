//
//  ShowFeature.swift
//  Show
//
//  Created by 김민석 on 2/22/24.
//

import Foundation

import Common
import ComposableArchitecture

@Reducer
public struct ShowFeature {
    public init() { }
    
    public enum ShowType {
        case theater
        case musical
        
        var title: String {
            switch self {
            case .theater: return "연극"
            case .musical: return "뮤지컬"
            }
        }
        var APIName: String {
            switch self {
            case .theater: return "PLAY"
            case .musical: return "MUSICAL"
            }
        }
    }
    
    public struct State: Equatable {
        public init() { }
        var selectedShowType: ShowType = .theater
        var selectedCategory: ShowSortFeature.CategoryType = .popular
        var showList: [ShowResponseContent] = []
        var page: Int = 0
        @PresentationState var bottomSheet: ShowSortFeature.State?
        var isShowTooltip = !UserDefaults.standard.bool(forKey: UserDefaultKeys.isShowPopluarTooltip.rawValue)
        var path = StackState<Path.State>()
    }
    
    public enum Action {
        case fetchShowList(page: Int)
        case didTappedShowType(ShowType)
        case didTappedCategory
        case bottomSheet(PresentationAction<ShowSortFeature.Action>)
        case showListResponse([ShowResponseContent])
        case didScrollToLastItem
        case dismissTooltip
        case path(StackAction<Path.State, Path.Action>)
        case didTappedSearch
        case didTappedShow(showId: String)
    }
    
    @Dependency (\.showClient) var showClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchShowList(let page):
                state.page = page
                return .run { [
                    showType = state.selectedShowType,
                    categoryType = state.selectedCategory
                ] send in
                    try await send(.showListResponse(self.showClient.fetchShowList(page, showType, categoryType).content))
                }
                
            case .didTappedShowType(let type):
                if type == state.selectedShowType {
                    return .none
                }
                state.selectedShowType = type
                state.showList = []
                return .run { send in
                    await send(.fetchShowList(page: 0))
                }
            case .didTappedCategory:
                state.bottomSheet = ShowSortFeature.State(categoryType: state.selectedCategory)
                return .none
            case .bottomSheet(.presented(.didTappedCategory(let type))):
                defer { state.bottomSheet = nil }
                if state.selectedCategory == type { return .none }
                state.selectedCategory = type
                state.showList = []
                return .run { send in
                    await send(.fetchShowList(page: 0))
                }
            case .bottomSheet:
                return .none
            case .showListResponse(let response):
                state.showList.append(contentsOf: response)
                return .none
            case .didScrollToLastItem:
                return .run { [page = state.page] send in
                    await send(.fetchShowList(page: page + 1))
                }
            case .dismissTooltip:
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.isShowPopluarTooltip.rawValue)
                state.isShowTooltip = false
                return .none
            case .didTappedSearch:
                state.path.append(.showSearch())
                return .none
            case .path(.element(id: _, action: .showSeacrch(.didTappedCancelButton))):
                state.path.removeAll()
                return .none
            case .path(.element(id: _, action: .showSeacrch(.didTappedShow(let show)))):
                state.path.append(.showDetail(.init(showId: show.id)))
                return .none
            case .didTappedShow(let showId):
                state.path.append(.showDetail(.init(showId: showId)))
                return .none
            case .path: return .none
            }
        }
        .ifLet(\.$bottomSheet, action: \.bottomSheet) {
            ShowSortFeature()
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
    
    @Reducer
    public struct Path {
        public enum State: Equatable {
            case showSearch(ShowSearchFeature.State = .init(
                recentSearches: (UserDefaults.standard.array(forKey: UserDefaultKeys.showRecentSearches.rawValue) as? [String] ?? []).suffix(10)
            ))
            case showDetail(ShowDetailFeature.State = .init(showId: ""))
        }
        
        public enum Action {
            case showSeacrch(ShowSearchFeature.Action)
            case showDetail(ShowDetailFeature.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: \.showSearch, action: \.showSeacrch) {
                ShowSearchFeature()
            }
            
            Scope(state: \.showDetail, action: \.showDetail) {
                ShowDetailFeature()
            }
        }
    }
}


