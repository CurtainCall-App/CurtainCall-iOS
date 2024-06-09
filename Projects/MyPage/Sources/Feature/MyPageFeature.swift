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
        case didTappedFAQView
        case didTappedSettingView
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedNoticeView:
                state.path.append(.notice())
                return .none
            case .didTappedFAQView:
                state.path.append(.FAQ())
                return .none
            case .didTappedSettingView:
                state.path.append(.setting())
                return .none
            case .path(.element(id: _, action: .notice(.didTappedNoticeView(let id)))):
                state.path.append(.noticeDetail(.init(id: id)))
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
            case noticeDetail(NoticeDetailFeature.State = .init(id: 0))
            case FAQ(FAQFeature.State = .init())
            case setting(SettingFeature.State = .init())
        }
        
        public enum Action {
            case notice(NoticeFeature.Action)
            case noticeDetail(NoticeDetailFeature.Action)
            case FAQ(FAQFeature.Action)
            case setting(SettingFeature.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: \.notice, action: \.notice) {
                NoticeFeature()
            }
            Scope(state: \.noticeDetail, action: \.noticeDetail) {
                NoticeDetailFeature()
            }
            Scope(state: \.FAQ, action: \.FAQ) {
                FAQFeature()
            }
            Scope(state: \.setting, action: \.setting) {
                SettingFeature()
            }
        }
    }
}
