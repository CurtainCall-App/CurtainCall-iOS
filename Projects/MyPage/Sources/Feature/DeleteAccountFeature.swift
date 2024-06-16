//
//  DeleteAccountFeature.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct DeleteAccountFeature {
    
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

