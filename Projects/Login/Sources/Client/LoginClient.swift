//
//  LoginClient.swift
//  Login
//
//  Created by 김민석 on 1/17/24.
//

import Foundation
import AuthenticationServices

import ComposableArchitecture
import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKAuth
import NaverThirdPartyLogin

struct LoginClient {
    var signInApple: () async throws -> String
    var signInKakao: () async throws -> String
    var signInNaver: () async throws -> String
}

extension LoginClient: DependencyKey {
    static var liveValue = {
        Self(
            signInApple: signInApple,
            signInKakao: signInKakao,
            signInNaver: signInNaver
        )
    }()
    
    static func signInApple() async throws -> String {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        let appleLoginController = AppleLoginController(authorizationController: controller)
        return try await appleLoginController.perfomRequest()
    }
    
    static func signInKakao() async throws -> String {
        let kakaoLogin = KakaoLogin()
        if UserApi.isKakaoTalkLoginAvailable() {
            return try await kakaoLogin.loginWithKakaoTalk()
        } else {
            return try await kakaoLogin.loginWithKakaoAccount()
        }
    }
    
    static func signInNaver() async throws -> String {
        return try await NaverLogin().performRequest()
    }
}

// MARK: - AppleLogin

extension LoginClient {
    private class AppleLoginController: NSObject, ASAuthorizationControllerDelegate {
        private let authorizationController: ASAuthorizationController
        private var continuation: CheckedContinuation<String, Error>?
        
        init(authorizationController: ASAuthorizationController) {
            self.authorizationController = authorizationController
        }
        
        func perfomRequest() async throws -> String {
            return try await withCheckedThrowingContinuation { [weak self] continuation in
                guard let self else { return }
                self.continuation = continuation
                authorizationController.delegate = self
                authorizationController.performRequests()
            }
        }
        
        func authorizationController(
            controller: ASAuthorizationController,
            didCompleteWithAuthorization authorization: ASAuthorization
        ) {
            if let crediential = authorization.credential as? ASAuthorizationAppleIDCredential,
               let identityToken = crediential.identityToken,
               let token = String(data: identityToken, encoding: .utf8) {
                continuation?.resume(returning: token)
            } else {
                continuation?.resume(throwing: LoginError.appleIdTokenError)
            }
        }
        
        func authorizationController(
            controller: ASAuthorizationController,
            didCompleteWithError error: Error
        ) {
            continuation?.resume(throwing: error)
        }
    }
}

// MARK: - Kakao Login

extension LoginClient {
    private class KakaoLogin {
        private var continuation: CheckedContinuation<String, Error>?
        
        func loginWithKakaoTalk() async throws -> String {
            return try await withCheckedThrowingContinuation { [weak self] continuation in
                guard let self else { return }
                self.continuation = continuation
                DispatchQueue.main.async {
                    UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                        if let error {
                            continuation.resume(throwing: error)
                        } else if let oauthToken, let idToken = oauthToken.idToken {
                            continuation.resume(returning: idToken)
                        } else {
                            continuation.resume(throwing: LoginError.kakaoTalkLoginError)
                        }
                    }
                }
            }
        }
        
        func loginWithKakaoAccount() async throws -> String {
            return try await withCheckedThrowingContinuation { [weak self] continuation in
                guard let self else { return }
                self.continuation = continuation
                DispatchQueue.main.async {
                    UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                        if let error {
                            continuation.resume(throwing: error)
                        } else if let oauthToken, let idToken = oauthToken.idToken {
                            continuation.resume(returning: idToken)
                        } else {
                            continuation.resume(throwing: LoginError.kakaoTalkLoginError)
                        }
                    }
                }
            }
        }
        
        
    }
}

extension LoginClient {
    class NaverLogin: NSObject, NaverThirdPartyLoginConnectionDelegate {
        private var continuation: CheckedContinuation<String, Error>?
        private let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        func performRequest() async throws -> String {
            return try await withCheckedThrowingContinuation { [weak self] continuation in
                guard let self else { return }
                self.continuation = continuation
                self.setDelegate()
                self.requestNaverLogin()
                
            }
        }
        
        func setDelegate() {
            naverLoginInstance?.delegate = self
        }
        
        func requestNaverLogin() {
            DispatchQueue.main.async {
                self.naverLoginInstance?.requestThirdPartyLogin()
            }
        }
        
        func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
            if let accessToken = naverLoginInstance?.accessToken {
                print("Get Naver Access Token", accessToken)
                continuation?.resume(returning: accessToken)
            } else {
                continuation?.resume(throwing: LoginError.naverLoginError)
                print("Invalid Naver Access Token")
            }
        }
        
        func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
            print("Refresh Token")
        }
        
        func oauth20ConnectionDidFinishDeleteToken() {
            print("Delete Token")
        }
        
        func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
            continuation?.resume(throwing: error)
        }
        
    }
}

extension DependencyValues {
    var loginClient: LoginClient {
        get { self[LoginClient.self] }
        set { self[LoginClient.self] = newValue }
    }
}
