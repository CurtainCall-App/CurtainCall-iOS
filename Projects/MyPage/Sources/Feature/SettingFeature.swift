//
//  SettingFeature.swift
//  MyPage
//
//  Created by 김민석 on 6/9/24.
//

import SwiftUI

import Common

import ComposableArchitecture

@Reducer
public struct SettingFeature {
    
    @ObservableState
    public struct State: Equatable {
        public static func == (lhs: SettingFeature.State, rhs: SettingFeature.State) -> Bool {
            lhs.logoutPopup == rhs.logoutPopup
        }
        
        public init() { }
        var logoutPopup: CurtainCallPopupFeature.State?
        var deleteAccountPopup: CurtainCallPopupFeature.State?
    }
    
    public enum Action {
        case logoutPopup(CurtainCallPopupFeature.Action)
        case deleteAccountPopup(CurtainCallPopupFeature.Action)
        case didTappedLogout
        case didTappedDeleteAccount
        case deleteAccount
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .logoutPopup(.didTappedCancel):
                state.logoutPopup = nil
                return .none
            case .logoutPopup:
                return .none
            case .deleteAccountPopup(.didTappedCancel):
                state.deleteAccountPopup = nil
                return .none
            case .deleteAccountPopup:
                return .none
            case .didTappedLogout:
                state.logoutPopup = .init(
                    title: "로그아웃 할까요?",
                    cancelText: "아니요",
                    allowText: "로그아웃"
                )
                return .none
            case .didTappedDeleteAccount:
                state.deleteAccountPopup = .init(
                    title: "계정을 삭제할까요?",
                    message: "계정을 삭제하면 해당 기기의 모든 데이터가 삭제된다는 점을 유의해주세요. 계속할까요?",
                    cancelText: "아니요",
                    allowText: "네, 삭제할게요"
                )
                return .none
            case .deleteAccount:
                return .none
            }
        }
    }
}

