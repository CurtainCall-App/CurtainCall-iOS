//
//  ShowSortFeature.swift
//  Show
//
//  Created by 김민석 on 2/25/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ShowSortFeature {
    public init() { }
    
    public enum CategoryType: CaseIterable {
        case popular
        case star
        case endTime
        case dictionary
        
        var title: String {
            switch self {
            case .popular: return "인기순"
            case .star: return "별점순"
            case .endTime: return "종료 임박순"
            case .dictionary: return "가나다순"
            }
        }
    }
    
    public struct State: Equatable {
        public init(categoryType: CategoryType) {
            self.categoryType = categoryType
        }
        var categoryType: CategoryType
    }
    
    public enum Action {
        case didTappedCategory(CategoryType)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedCategory:
                return .none
            }
        }
    }
}
