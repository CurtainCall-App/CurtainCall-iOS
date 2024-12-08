//
//  FavoriteShowFeature.swift
//  FavoriteShow
//
//  Created by 김민석 on 12/8/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct FavoriteShowFeature {
    
    public init() { }
    
    @ObservableState
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

