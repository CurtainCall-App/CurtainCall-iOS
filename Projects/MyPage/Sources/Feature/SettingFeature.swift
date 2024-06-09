//
//  SettingFeature.swift
//  MyPage
//
//  Created by 김민석 on 6/9/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct SettingFeature {
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        
        var popup: CurtainCallPopupFeature.State?
    }
    
    public enum Action {
        case popup(CurtainCallPopupFeature.Action)
        case didTappedLogout
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .popup: return .none
            case .didTappedLogout:
                state.popup = .init(
                    title: "로그아웃 할까요?",
                    cancelText: "아니요",
                    allowText: "로그아웃"
                )
                return .none
            }
        }
    }
}

