//
//  AppleLoginClient.swift
//  CurtainCall
//
//  Created by 김민석 on 1/4/24.
//

import UIKit
import AuthenticationServices

import ComposableArchitecture

struct AppleLoginClient {
    var signIn: () async throws -> String
}

extension AppleLoginClient: DependencyKey {
    static var liveValue = {
        Self(signIn: signIn)
    }()
    
    static func signIn() async throws -> String {
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
                continuation?.resume(returning: token)
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
    var appleLoginClient: AppleLoginClient {
        get { self[AppleLoginClient.self] }
        set { self[AppleLoginClient.self] = newValue }
    }
}
