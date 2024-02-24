//
//  PartyFeature.swift
//  Party
//
//  Created by 김민석 on 2/22/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct PartyFeature {
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

