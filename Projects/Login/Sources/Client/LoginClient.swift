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

struct LoginClient {
    var signInApple: () async throws -> String
    var signInKakao: () async throws -> Void
}

extension LoginClient: DependencyKey {
    static var liveValue = {
        Self(
            signInApple: signInApple,
            signInKakao: signInKakao
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
    
    static func signInKakao() async {
        if UserApi.isKakaoTalkLoginAvailable() {
            DispatchQueue.main.async {
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error {
                        print("#Error#", error)
                    } else {
                        print("#Ouath#", oauthToken?.accessToken)
                    }
                }
            }
        } else {
            
        }
    }
}

// MARK: - AppleLogin 관련

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

extension DependencyValues {
    var loginClient: LoginClient {
        get { self[LoginClient.self] }
        set { self[LoginClient.self] = newValue }
    }
}
