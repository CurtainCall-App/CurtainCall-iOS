//
//  LoginFeature.swift
//  Login
//
//  Created by 김민석 on 1/15/24.
//

import Foundation

import Common
import TermsOfService
import ComposableArchitecture
import NicknameSetting

@Reducer
public struct LoginFeature {
    public init() { }
    
    public struct State: Equatable {
        public init() { }
        var loginType: LoginType?
        var path = StackState<Path.State>()
        var appRootView: AppRootManager.AppRootType = .login
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case appleLoginTapped
        case kakaoLoginTapped
        case naverLoginTapped
        case idTokenReseponse(String)
        case idTokenError(Error)
        case requestLogin(LoginResponseDTO)
        case withoutLoginButtonTapped
        case path(StackAction<Path.State, Path.Action>)
    }
    
    @Dependency(\.loginClient) var loginClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .appleLoginTapped:
                state.loginType = .apple
                return .run { send in
                    do {
                        try await send(.idTokenReseponse(self.loginClient.signInApple()))
                    } catch {
                        await send(.idTokenError(error))
                    }
                }
            case .kakaoLoginTapped:
                state.loginType = .kakao
                return .run { send in
                    do {
                        try await send(.idTokenReseponse(self.loginClient.signInKakao()))
                    } catch {
                        await send(.idTokenError(error))
                    }
                }
            case .naverLoginTapped:
                state.loginType = .naver
                return .run { send in
                    do {
                        try await send(.idTokenReseponse(self.loginClient.signInNaver()))
                    } catch {
                        await send(.idTokenError(error))
                    }
                }
            case .idTokenReseponse(let token):
                print("token: \(token)")
                return .run { [loginType = state.loginType] send in
                    guard let loginType else { return }
                    try await send(.requestLogin(self.loginClient.requestLogin(loginType, token)))
                }
                
            case .idTokenError(let error):
                print(error.localizedDescription)
                return .none
                
            case .requestLogin(let response):
                if let memberId = response.memberId {
                    state.appRootView = .main
                } else {
                    state.path.append(.termsOfService())
                }
                UserDefaults.standard.setValue(response.accessToken, forKey: UserDefaultKeys.accessToken.rawValue)
                return .none
            case .withoutLoginButtonTapped:
                return .none
                
            case .binding(_):
                return .none
            case .path(.element(id: _, action: .termsOfService(.nextButtonTapped))):
                state.path.append(.nicknameSetting())
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
        public enum State: Equatable {
            case termsOfService(TermsOfServiceFeature.State = .init())
            case nicknameSetting(NicknameSettingFeature.State = .init())
        }
        
        public enum Action {
            case termsOfService(TermsOfServiceFeature.Action)
            case nicknameSetting(NicknameSettingFeature.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: \.termsOfService, action: \.termsOfService) {
                TermsOfServiceFeature()
            }
            Scope(state: \.nicknameSetting, action: \.nicknameSetting) {
                NicknameSettingFeature()
            }
        }
    }
}
