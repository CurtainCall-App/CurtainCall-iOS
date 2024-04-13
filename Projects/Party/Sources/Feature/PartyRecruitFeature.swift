//
//  PartyRecruitFeature.swift
//  Party
//
//  Created by 김민석 on 4/11/24.
//

import Foundation

import Common
import Show

import ComposableArchitecture

@Reducer
public struct PartyRecruitFeature {
    
    enum ViewType {
        case step1
        case step2
        case step3
    }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var viewType: ViewType = .step1
        var selectedShowType: ShowFeature.ShowType = .theater
        var selectedCategory: ShowSortFeature.CategoryType = .popular
        var showList: [ShowResponseContent] = []
        var page: Int = 0
    }
    
    @Dependency (\.showClient) var showClient
    
    public enum Action {
        case fetchShowList(page: Int)
        case showListResponse([ShowResponseContent])
        case didScrollToLastItem
    }
    
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
            case .showListResponse(let response):
                state.showList.append(contentsOf: response)
                return .none
            case .didScrollToLastItem:
                return .run { [page = state.page] send in
                    await send(.fetchShowList(page: page + 1))
                }
            }
        }
    }
}
