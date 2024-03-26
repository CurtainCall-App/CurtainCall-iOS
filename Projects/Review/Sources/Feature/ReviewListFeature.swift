//
//  ReviewListFeature.swift
//  Review
//
//  Created by 김민석 on 3/24/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ReviewListFeature {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action {
        
    }
    
    @Dependency(\.reviewClient) var reviewClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
