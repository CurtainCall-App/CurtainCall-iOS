//
//  LoginClient.swift
//  CurtainCall
//
//  Created by 김민석 on 1/4/24.
//

import UIKit
import AuthenticationServices
import Combine

import ComposableArchitecture
import Moya

struct LoginClient {
    var signInApple: () async throws -> String
    var requestLogin: (String) async throws -> Bool
}

extension LoginClient: DependencyKey {
    static var liveValue = {
        Self(
            signInApple: signInApple,
            requestLogin: requestLogin(idToken:)
        )
    }()
    
    static func requestLogin(idToken: String) async throws -> Bool {
        let provider = MoyaProvider<LoginAPI>()
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.apple(idToken)) { result in
                switch result {
                case .success(let response):
                    if response.statusCode == 404 {
                        UserDefaults.standard[.idToken] = idToken
                        continuation.resume(returning: false)
                        return
                    }
                    do {
                        let data = try JSONDecoder().decode(AuthenticationResponse.self, from: response.data)
                        UserDefaults.standard[.accessToken] = data.accessToken
                        UserDefaults.standard[.userId] = data.memberId
                        UserDefaults.standard[.loginType] = .apple
                        continuation.resume(returning: true)
                    } catch {
                        continuation.resume(throwing: NSError(domain: "DecodeError", code: 100))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
    }
    
    static func signInApple() async throws -> (String) {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        let appleLoginController = AppleLoginController(authorizationController: controller)
        return try await appleLoginController.performRequest()
    }
    
    class AppleLoginController: NSObject, ASAuthorizationControllerDelegate {
        
        private let authorizationController: ASAuthorizationController
        private var continuation: CheckedContinuation<String, Error>?
        
        init(authorizationController: ASAuthorizationController) {
            self.authorizationController = authorizationController
        }
        
        func performRequest() async throws -> String {
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
                continuation?.resume(returning: (token))
            } else {
                // MARK: Error처리
                continuation?.resume(throwing: NSError(domain: "Apple Crediential Error", code: 1995))
            }
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
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
