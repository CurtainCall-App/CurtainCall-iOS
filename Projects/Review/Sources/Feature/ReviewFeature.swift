//
//  ReviewFeature.swift
//  Review
//
//  Created by 김민석 on 3/16/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ReviewFeature {
    public init() { }
    
    public struct State: Equatable {
        public init(showId: String) {
            self.showId = showId
        }
        private let showId: String
    }
    
    public enum Action {
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
