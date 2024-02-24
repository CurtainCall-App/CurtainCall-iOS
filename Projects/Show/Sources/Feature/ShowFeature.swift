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
    }
    
    public enum Action {
        case didTappedShowType(ShowType)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedShowType(let type):
                state.selectedShowType = type
                return .none
            }
        }
    }
}


