//
//  MyPageFeature.swift
//  MyPage
//
//  Created by 김민석 on 2/22/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct MyPageFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var path = StackState<Path.State>()
        var userInfo: FetchUserInfoResponseDTO?
    }
    
    public enum Action {
        case didTappedNoticeView
        case didTappedFAQView
        case didTappedSettingView
        case didTappedProfileView
        case fetchUserInfo
        case responseUserInfo(FetchUserInfoResponseDTO)
        case responseError(Error)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    @Dependency(\.userClient) var client
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchUserInfo:
                return .run { send in
                    do {
                        try await send(.responseUserInfo(client.fetchUserInfo(UserDefaults.standard.integer(forKey: UserDefaultKeys.userId.rawValue))))
                    } catch {
                        await send(.responseError(error))
                    }
                }
            case .responseUserInfo(let response):
                state.userInfo = response
                return .none
            case .responseError(let error):
                print(error.localizedDescription)
                return .none
            case .didTappedNoticeView:
                state.path.append(.notice())
                return .none
            case .didTappedFAQView:
                state.path.append(.FAQ())
                return .none
            case .didTappedSettingView:
                state.path.append(.setting())
                return .none
            case .didTappedProfileView:
                state.path.append(.profile())
                return .none
            case .path(.element(id: _, action: .notice(.didTappedNoticeView(let id)))):
                state.path.append(.noticeDetail(.init(id: id)))
                return .none
            case .path(.element(id: _, action: .setting(.deleteAccount))):
                state.path.append(.deleteAccount(.init()))
                return .none
            case .path(.element(id: _, action: .deleteAccount(.didTappedDeleteAccount(let type, let content)))):
                state.path.append(.deleteAccountDetail(.init(body: .init(reason: type.APIName, content: content))))
                return .none
            case .path(.element(id: _, action: .profile(.isSuccessUpdateUserInfo(let isSuccess)))):
                if isSuccess {
                    state.path.removeLast()
                }
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
            case deleteAccount(DeleteAccountFeature.State = .init())
            case deleteAccountDetail(DeleteAccountDetailFeature.State = .init(body: DeleteAccountBody(reason: "", content: "")))
            case profile(ProfileFeature.State = .init())
        }
        
        public enum Action {
            case notice(NoticeFeature.Action)
            case noticeDetail(NoticeDetailFeature.Action)
            case FAQ(FAQFeature.Action)
            case setting(SettingFeature.Action)
            case deleteAccount(DeleteAccountFeature.Action)
            case deleteAccountDetail(DeleteAccountDetailFeature.Action)
            case profile(ProfileFeature.Action)
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
            Scope(state: \.deleteAccount, action: \.deleteAccount) {
                DeleteAccountFeature()
            }
            Scope(state: \.deleteAccountDetail, action: \.deleteAccountDetail) {
                DeleteAccountDetailFeature()
            }
            Scope(state: \.profile, action: \.profile) {
                ProfileFeature()
            }
        }
    }
}
