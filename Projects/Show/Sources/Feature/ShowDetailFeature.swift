//
//  ShowDetailFeature.swift
//  Show
//
//  Created by 김민석 on 3/3/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ShowDetailFeature {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action {
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
