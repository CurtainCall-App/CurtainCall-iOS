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
    
    public enum DeleteAccountType: CaseIterable {
        case 기록삭제
        case 이용불편
        case 타서비스
        case 사용빈도
        case 앱기능문제
        case 기타
        
        public var title: String {
            switch self {
            case .기록삭제: return "기록을 삭제하기 위해"
            case .이용불편: return "이용이 불편하고 장애가 잦아서"
            case .타서비스: return "타 서비스가 더 좋아서"
            case .사용빈도: return "사용빈도가 낮아서"
            case .앱기능문제: return "앱 기능이 유용하지 않아서"
            case .기타: return "기타"
            }
        }
    }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var content: String = ""
        var deleteAccountType: DeleteAccountType?
        var isEnableDeleteAccount: Bool = false
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case check(DeleteAccountType)
        case didTappedDeleteAccount
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .check(let type):
                state.deleteAccountType = type
                state.isEnableDeleteAccount = true
                return .none
            case .didTappedDeleteAccount:
                return .none
            }
        }
    }
}

