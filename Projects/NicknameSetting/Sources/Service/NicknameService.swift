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
}

extension NicknameAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    var path: String { "/members/duplicate/nickname"}
    var method: Moya.Method { .get }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .duplicatedNickname(let nickname):
            param.updateValue(nickname, forKey: "nickname")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var header: [String: String] = [:]
        switch self {
        case .duplicatedNickname:
            if let accessToken = UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue) {
                header.updateValue(accessToken, forKey: "Authorization")
            }
            return header
        }
    }
}
