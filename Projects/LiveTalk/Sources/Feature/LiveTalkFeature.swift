//
//  LiveTalkFeature.swift
//  LiveTalk
//
//  Created by 김민석 on 12/22/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct LiveTalkFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action {
        case viewDidLoad
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
