//
//  NicknameService.swift
//  NicknameSetting
//
//  Created by 김민석 on 2/11/24.
//

import Foundation

import Common
import Moya

enum NicknameAPI {
    case duplicatedNickname(String)
    case signup(String)
}

extension NicknameAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    var path: String {
        switch self {
        case .duplicatedNickname:
            return "/members/duplicate/nickname"
        case .signup:
            return "/signup"
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .duplicatedNickname: return .get
        case .signup: return .post
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .duplicatedNickname(let nickname):
            param.updateValue(nickname, forKey: "nickname")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .signup(let nickname):
            let body = SigninBodyDTO(nickname: nickname)
            return .requestJSONEncodable(body)
        }
    }
    
    var headers: [String : String]? {
        var header: [String: String] = [:]
        if let accessToken = UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue) {
            header.updateValue("Bearer \(accessToken)", forKey: "Authorization")
        }
        return header
    }
}
