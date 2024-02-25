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
    }
    
    public struct State: Equatable {
        public init() { }
        var selectedShowType: ShowType = .theater
        var selectedCategory: ShowSortFeature.CategoryType = .popular
        @PresentationState var bottomSheet: ShowSortFeature.State?
    }
    
    public enum Action {
        case didTappedShowType(ShowType)
        case didTappedCategory
        case bottomSheet(PresentationAction<ShowSortFeature.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedShowType(let type):
                state.selectedShowType = type
                return .none
            case .didTappedCategory:
                state.bottomSheet = ShowSortFeature.State(categoryType: state.selectedCategory)
                return .none
            case .bottomSheet(.presented(.didTappedCategory(let type))):
                state.selectedCategory = type
                state.bottomSheet = nil
                return .none
            case .bottomSheet:
                return .none
            }
        }
        .ifLet(\.$bottomSheet, action: \.bottomSheet) {
            ShowSortFeature()
        }
    }
}


