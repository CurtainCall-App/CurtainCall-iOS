//
//  ProfileFeature.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

import Common
import NicknameSetting

import ComposableArchitecture

@Reducer
public struct ProfileFeature {
    
    public enum ProfileModeType {
        case normal
        case edit
    }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var userInfo: FetchUserInfoResponseDTO?
        var enableComplete: Bool = false
        var enableDuplicatedButtonTapped: Bool = false
        var modeType: ProfileModeType = .normal
        var nicknameText: String = ""
        var isValidCount: Bool = false
        var isValidRegex: Bool = false
        var isTappedDuplicatedButton: Bool = false
        var isPossibleNickname: Bool = false
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case fetchUserInfo
        case responseUserInfo(FetchUserInfoResponseDTO)
        case responseError(Error)
        case responseNicknameDuplicated(Bool)
        case didTappedEditButton
        case duplicatedCheckButtonTapped
    }
    
    @Dependency(\.userClient) var client
    @Dependency (\.nicknameSettingClient) var nicknameSettingClient
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(\.nicknameText):
                state.isValidCount = isValidCount(state.nicknameText)
                state.isValidRegex = isValidRegex(state.nicknameText)
                state.enableComplete = false
                state.enableDuplicatedButtonTapped = false
                return .none
            case .binding: return .none
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
                print(error)
                return .none
            case .didTappedEditButton:
                state.modeType = .edit
                return .none
            case .duplicatedCheckButtonTapped:
                guard state.isValidCount && state.isValidRegex else { return .none }
                
                return .run { [nickname = state.nicknameText] send in
                    let result = try await nicknameSettingClient.checkDuplicatedNickname(nickname)
                    await send(.responseNicknameDuplicated(result.result))
                }
            case .responseNicknameDuplicated(let result):
                state.isPossibleNickname = !result
                state.isTappedDuplicatedButton = true
                return .none
            }
        }
    }
    
    private func isValidCount(_ nickname: String) -> Bool {
        return !nickname.contains(" ") && (1...15) ~= nickname.count
    }
    
    private func isValidRegex(_ nickname: String) -> Bool {
        return nickname.isValidRegex("^[가-힣a-zA-Z0-9]*$") && !nickname.isEmpty
    }
}

