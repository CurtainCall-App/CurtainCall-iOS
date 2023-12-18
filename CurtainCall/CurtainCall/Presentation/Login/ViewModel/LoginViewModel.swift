//
//  LoginViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/06/26.
//

import Foundation
import AuthenticationServices
import Combine

import KakaoSDKCommon
import KakaoSDKAuth
import FacebookLogin
import GoogleSignIn
import Moya
import CombineMoya
import SwiftKeychainWrapper

protocol LoginViewModelInput {
    func requestLogin(crendential: ASAuthorizationAppleIDCredential?, error: Error?)
    func requestLogin(oauthToken: OAuthToken?, error: Error?)
    func requestLogin(result: LoginManagerLoginResult?, error: Error?)
    func requestLogin(result: GIDSignInResult?, error: Error?)
}

protocol LoginViewModelOutput {
    var loginPublisher: PassthroughSubject<(LoginType, Int?), Error> { get set }
}

protocol LoginViewModelIO: LoginViewModelInput & LoginViewModelOutput { }

final class LoginViewModel: LoginViewModelIO {
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    private let loginProvider = MoyaProvider<LoginAPI>()
    var loginPublisher = PassthroughSubject<(LoginType, Int?), Error>()
    weak var loginViewController: UIViewController?
    
    // MARK: - Helpers
    
    func requestLogin(crendential: ASAuthorizationAppleIDCredential?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        
        guard let crendential, let token = crendential.identityToken,
        let idToken = String(data: token, encoding: .utf8) else
        {
            return
        }
        loginProvider.requestPublisher(.apple(idToken))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.loginPublisher.send(completion: .failure(error))
                case .finished:
                    return
                }
            }, receiveValue: { [weak self] response in
                print("###", String(data: response.data, encoding: .utf8))
                print(idToken)
                if response.statusCode == 404 {
                    UserDefaults.standard[.idToken] = idToken
                    self?.loginPublisher.send((.apple, nil))
                } else if let data = try? response.map(AuthenticationResponse.self) {
                    UserDefaults.standard[.accessToken] = data.accessToken
                    UserDefaults.standard[.userId] = data.memberId
                    print("@@", data.memberId)
                    print("@@", UserDefaults.standard[.userId])
                    self?.loginPublisher.send((.apple, data.memberId))
                }
                UserDefaults.standard[.loginType] = LoginType.apple
            }).store(in: &self.cancellables)
    }
    
    func requestLogin(oauthToken: OAuthToken?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        if let oauthToken, let idToken = oauthToken.idToken {
            self.loginProvider.requestPublisher(.kakao(idToken))
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    switch completion {
                    case .failure(let error):
                        self.loginPublisher.send(completion: .failure(error))
                    case .finished:
                        return
                    }
                }, receiveValue: { [weak self] response in
                    print("###", String(data: response.data, encoding: .utf8))
                    if response.statusCode == 404 {
                        UserDefaults.standard[.idToken] = idToken
                        self?.loginPublisher.send((.kakao, nil))
                        
                    } else if let data = try? response.map(AuthenticationResponse.self) {
                        UserDefaults.standard[.accessToken] = data.accessToken
                        UserDefaults.standard[.userId] = data.memberId
                        self?.loginPublisher.send((.kakao, data.memberId))
                    }
                    UserDefaults.standard[.loginType] = LoginType.kakao
                }).store(in: &self.cancellables)
        }
        
    }
    
    func requestLogin(result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        
//        if let result, let token = result.token?.tokenString {
//            useCase.loginWithFacebook(token: token)
//                .sink { [weak self] completion in
//                    switch completion {
//                    case .failure(let error):
//                        self?.loginPublisher.send(completion: .failure(error))
//                    case .finished:
//                        return
//                    }
//                } receiveValue: { [weak self] token in
//                    print(token)
//                    self?.loginPublisher.send((.facebook, nil))
//                }.store(in: &cancellables)
//        }
    }
    
    func requestLogin(result: GIDSignInResult?, error: Error?) {
        if let error {
            loginPublisher.send(completion: .failure(error))
        }
        
//        if let result {
//            useCase.loginWithGoogle(token: result.user.accessToken.tokenString)
//                .sink { [weak self] completion in
//                    switch completion {
//                    case .failure(let error):
//                        self?.loginPublisher.send(completion: .failure(error))
//                    case .finished:
//                        return
//                    }
//                } receiveValue: { [weak self] token in
//                    print(token)
//                    self?.loginPublisher.send((.google, nil))
//                }.store(in: &cancellables)
//        }
    }
    
    
}
