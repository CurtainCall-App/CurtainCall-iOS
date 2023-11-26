//
//  nicknameService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/16.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum SignUpAPI {
    case duplicate(String)
    case signUp(String)
}

extension SignUpAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    var path: String {
        switch self {
        case .duplicate: return "/members/duplicate/nickname"
        case .signUp: return "/signup"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .duplicate:
            return .get
        case .signUp:
            return .post
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .duplicate(let nickname):
            param.updateValue(nickname, forKey: "nickname")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .signUp(let nickname):
            param.updateValue(nickname, forKey: "nickname")
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .duplicate:
            return nil
        case .signUp:
            guard let idToken = KeychainWrapper.standard.string(forKey: .idToken) else {
                return nil
            }
            return ["Authorization": "Bearer \(idToken)"]
        }
        
    }
}
