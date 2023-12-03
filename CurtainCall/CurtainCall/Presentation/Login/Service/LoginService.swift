//
//  LoginService.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/13.
//

import Foundation
import Moya

enum LoginAPI {
    case kakao(String)
    case apple(String)
}

extension LoginAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    var path: String {
        switch self {
        case .kakao:
            return "/login"
        case .apple:
            return "/login"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        return .requestPlain
//        var param: [String: Any] = [:]
//        switch self {
            
//        case .kakao(let token):
//            param.updateValue(token, forKey: "accessToken")
//            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
//        case .apple(let token):
//            param.updateValue(token, forKey: "accessToken")
//            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
//        }
    }
    
    var headers: [String : String]? {
        var header: [String: String] = [:]
        switch self {
        case .kakao(let idToken):
            header.updateValue("Bearer \(idToken)", forKey: "Authorization")
        case .apple(let idToken):
            header.updateValue("Bearer \(idToken)", forKey: "Authorization")
        }
        return header
        
    }
    
    
}
