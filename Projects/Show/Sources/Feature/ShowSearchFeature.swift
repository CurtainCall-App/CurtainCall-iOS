//
//  ShowSearchFeature.swift
//  Show
//
//  Created by 김민석 on 3/1/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct ShowSearchFeature {
    public init() { }
    
    public struct State: Equatable {
        public init(recentSearches: [String]) {
            self.recentSearches = recentSearches
        }
        @BindingState var showTitleText: String = ""
        var recentSearches: [String]
        var showList: [ShowResponseContent] = []
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case didTappedCancelButton
        case didTappedRemoveRecentSearches(index: Int)
        case didTappedAllRemoveRecentSearches
        case showListResponse([ShowResponseContent])
        case fetchShowList(keyword: String)
    }
    
    @Dependency (\.showClient) var showClient
    @Dependency (\.continuousClock) var clock
    
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(\.$showTitleText):
                if state.showTitleText.isEmpty { return .none }
                return .run { [showTitle = state.showTitleText] send in
                    await send(.fetchShowList(keyword: showTitle))
                }
            case .binding:
                return .none
            case .didTappedCancelButton:
                return .none
            case .didTappedRemoveRecentSearches(let index):
                state.recentSearches.remove(at: index)
                UserDefaults.standard.setValue(state.recentSearches, forKey: UserDefaultKeys.showRecentSearches.rawValue)
                return .none
            case .didTappedAllRemoveRecentSearches:
                state.recentSearches = []
                UserDefaults.standard.setValue([], forKey: UserDefaultKeys.showRecentSearches.rawValue)
                return .none
            case .fetchShowList(let keyword):
                return .run { send in
                    try await send(.showListResponse(self.showClient.fetchShowSearchList(keyword).content))
                }
                
            case .showListResponse(let response):
                state.showList = response
                return .none
            }
        }
    }
}
