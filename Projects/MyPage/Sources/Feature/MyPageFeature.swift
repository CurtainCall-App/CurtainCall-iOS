//
//  MyPageFeature.swift
//  MyPage
//
//  Created by 김민석 on 2/22/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct MyPageFeature {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
        var path = StackState<Path.State>()
    }
    
    public enum Action {
        case didTappedNoticeView
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedNoticeView:
                state.path.append(.notice())
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
    
    @Reducer
    public struct Path {
        
        @ObservableState
        public enum State: Equatable {
            case notice(NoticeFeature.State = .init())
        }
        
        public enum Action {
            case notice(NoticeFeature.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: \.notice, action: \.notice) {
                NoticeFeature()
            }
        }
    }
}
