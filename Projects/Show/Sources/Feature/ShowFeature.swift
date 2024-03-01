//
//  ShowFeature.swift
//  Show
//
//  Created by 김민석 on 2/22/24.
//

import Foundation

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
    }
    
    public enum Action {
        case fetchShowList(page: Int)
        case didTappedShowType(ShowType)
        case didTappedCategory
        case bottomSheet(PresentationAction<ShowSortFeature.Action>)
        case showListResponse([ShowResponseContent])
    }
    
    @Dependency (\.showClient) var showClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchShowList(let page):
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
                return .run { send in
                    await send(.fetchShowList(page: 0))
                }
            case .didTappedCategory:
                state.bottomSheet = ShowSortFeature.State(categoryType: state.selectedCategory)
                return .none
            case .bottomSheet(.presented(.didTappedCategory(let type))):
                state.selectedCategory = type
                state.bottomSheet = nil
                return .none
            case .bottomSheet:
                return .none
            case .showListResponse(let response):
                state.showList = response
                return .none
            }
        }
        .ifLet(\.$bottomSheet, action: \.bottomSheet) {
            ShowSortFeature()
        }
    }
}


