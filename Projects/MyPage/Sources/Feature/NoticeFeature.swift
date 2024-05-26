//
//  NoticeFeature.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct NoticeFeature {
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

