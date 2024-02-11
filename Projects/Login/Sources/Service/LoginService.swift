//
//  LoginService.swift
//  Login
//
//  Created by 김민석 on 1/19/24.
//

import Foundation

import Common
import Moya

enum LoginAPI {
    case apple(String)
    case kakao(String)
    case naver(String)
    
    var apiName: String {
        switch self {
        case .apple: return "apple"
        case .kakao: return "kakao"
        case .naver: return "naver"
        }
    }
    
    init?(loginType: LoginType, token: String) {
        switch loginType {
        case .apple: self = .apple(token)
        case .kakao: self = .kakao(token)
        case .naver: self = .naver(token)
        }
    }
}

extension LoginAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    var path: String { "/login/oauth2/token/\(self.apiName)" }
    var method: Moya.Method { .post }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        
        switch self {
        case .apple(let token):
            param.updateValue(token, forKey: "token")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .kakao(let token):
            param.updateValue(token, forKey: "token")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .naver(let token):
            param.updateValue(token, forKey: "token")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
}
