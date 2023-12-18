//
//  LoginCompleteViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/16.
//

import Foundation
import Combine

import Moya
import CombineMoya
import SwiftKeychainWrapper

final class LoginCompleteViewModel {
    
    private let signupProvider = MoyaProvider<SignUpAPI>()
    private let loginProvider = MoyaProvider<LoginAPI>()
    private var cancellables: Set<AnyCancellable> = []
    var isSuccessSignUp = PassthroughSubject<Bool, Error>()
    
    func signUpButtonTapped(nickname: String) {
        signupProvider.requestPublisher(.signUp(nickname))
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.isSuccessSignUp.send(completion: .failure(error))
                    return
                }
            } receiveValue: { [weak self] response in
                print(response.statusCode)
                print(UserDefaults.standard[.idToken])
                if (200..<300) ~= response.statusCode {
                    self?.isSuccessSignUp.send(true)
                }
                print("###", String(data: response.data, encoding: .utf8))
                if let data = try? response.map(SignUpResponse.self) {
                    self?.isSuccessSignUp.send(true)
                    UserDefaults.standard[.userId] = data.id
//                    UserDefaults.standard[.accessToken] = data.accessToken
                } else {
                    self?.isSuccessSignUp.send(false)
                }
            }.store(in: &cancellables)
    }
    
    func requestLogin() {
        guard let loginType = UserDefaults.standard[.loginType] else {
            return
        }
        switch loginType {
        case .kakao:
            requestKakaoLogin()
        case .apple:
            requestAppleLogin()
        case .google:
            print("Google Login")
        case .facebook:
            print("Facebook Login")
            
        
        }
    }
    
    private func requestKakaoLogin() {
        guard let idToken = UserDefaults.standard[.idToken] else {
            print("apple idToken not exist")
            return
        }
        self.loginProvider.requestPublisher(.kakao(idToken))
            .sink(receiveCompletion:  { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    return
                case .failure:
                    self.isSuccessSignUp.send(false)
                }
            }, receiveValue: { [weak self] response in
                if let data = try? response.map(AuthenticationResponse.self) {
                    UserDefaults.standard[.accessToken] = data.accessToken
                    UserDefaults.standard[.userId] = data.memberId
                    UserDefaults.standard[.isNotGuestUser] = true
                    self?.isSuccessSignUp.send(true)
                }
            })
            .store(in: &cancellables)
    }
    
    private func requestAppleLogin() {
        guard let idToken = UserDefaults.standard[.idToken] else {
            print("apple idToken not exist")
            return
        }
        self.loginProvider.requestPublisher(.apple(idToken))
            .sink(receiveCompletion:  { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    return
                case .failure:
                    self.isSuccessSignUp.send(false)
                }
            }, receiveValue: { [weak self] response in
                if let data = try? response.map(AuthenticationResponse.self) {
                    UserDefaults.standard[.accessToken] = data.accessToken
                    UserDefaults.standard[.userId] = data.memberId
                    UserDefaults.standard[.isNotGuestUser] = true
                    self?.isSuccessSignUp.send(true)
                }
            })
            .store(in: &cancellables)
    }
}
