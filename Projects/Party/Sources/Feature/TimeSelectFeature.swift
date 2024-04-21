//
//  TimeSelectFeature.swift
//  Party
//
//  Created by 김민석 on 4/21/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct TimeSelectFeature {
    
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        var times: [String]
        public init(times: [String]) {
            self.times = times
        }
        
    }
    
    public enum Action {
        case didTappedTime(String)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedTime:
                return .none
            }
        }
    }
}

