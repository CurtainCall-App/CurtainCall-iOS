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
        var selectedShow: ShowResponseContent?
        var showList: [ShowResponseContent] = []
        var page: Int = 0
        var isPossibleNextButton = false
        @Presents var bottomSheet: ShowSortFeature.State?
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case fetchShowList(page: Int)
        case showListResponse([ShowResponseContent])
        case didScrollToLastItem
        case didTappedCategoryButton
        case bottomSheet(PresentationAction<ShowSortFeature.Action>)
        case didTappedNextButton
        case didTappedShowItem(ShowResponseContent)
    }
    
    @Dependency (\.showClient) var showClient
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
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
            case .didTappedCategoryButton:
                state.bottomSheet = .init(categoryType: state.selectedCategory)
                return .none
            case .didTappedNextButton:
                if !state.isPossibleNextButton { return .none }
                switch state.viewType {
                case .step1: 
                    state.viewType = .step2
                case .step2:
                    state.isPossibleNextButton = false
                    state.viewType = .step3
                case .step3:
                    if state.isPossibleNextButton {
                        
                    }
                }
                return .none
            case .didTappedShowItem(let item):
                state.selectedShow = nil
                state.selectedShow = item
                state.isPossibleNextButton = state.selectedShow != nil
                return .none
            case .didScrollToLastItem:
                return .run { [page = state.page] send in
                    await send(.fetchShowList(page: page + 1))
                }
            case .bottomSheet(.presented(.didTappedCategory(let type))):
                defer { state.bottomSheet = nil }
                if state.selectedCategory == type { return .none }
                state.selectedCategory = type
                state.showList = []
                return .run { send in
                    await send(.fetchShowList(page: 0))
                }
            case .bottomSheet: return .none
            case .binding: return .none
            }
        }
        .ifLet(\.$bottomSheet, action: \.bottomSheet) {
            ShowSortFeature()
        }
    }
}
