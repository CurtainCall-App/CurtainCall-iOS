//
//  Source.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/12/24.
//

import Foundation

import Moya

public final class AppRootManager: ObservableObject {
    @Published public var currentRoot: AppRootType = .splash
    
    public init() { }
    
    public enum AppRootType: String {
        case splash
        case onboarding
        case login
        case main
    }
    
    public func checkToken() {
        if let refreshToken = UserDefaults.standard.string(forKey: UserDefaultKeys.refreshToken.rawValue),
           let expiresAtString = UserDefaults.standard.string(forKey: UserDefaultKeys.refreshTokenExpiresAt.rawValue),
           let expiresAt = Utils.convertAPIDateForrmatToDate(dateString: expiresAtString) {
            if expiresAt > Date() {
                currentRoot = .main
                request(token: refreshToken)
            } else {
                currentRoot = .login
            }
        } else {
            currentRoot = .login
        }
    }
    
    private func request(token: String) {
        let provider = MoyaProvider<RefreshTokenAPI>()
        provider.request(.requestToken(token)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode(RequestRefreshTokenDTO.self, from: response.data)
                    UserDefaults.standard.setValue(data.accessToken, forKey: UserDefaultKeys.accessToken.rawValue)
                    UserDefaults.standard.setValue(data.refreshToken, forKey: UserDefaultKeys.refreshToken.rawValue)
                    UserDefaults.standard.setValue(data.refreshTokenExpiresAt, forKey: UserDefaultKeys.refreshTokenExpiresAt.rawValue)
                } catch {
                    print("error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
