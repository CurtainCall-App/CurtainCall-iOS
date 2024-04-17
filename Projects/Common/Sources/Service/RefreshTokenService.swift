//
//  RefreshTokenService.swift
//  Common
//
//  Created by 김민석 on 4/17/24.
//

import Foundation

import Moya

enum RefreshTokenAPI {
    case requestToken(String)
}

extension RefreshTokenAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    var path: String { "/login/refresh" }
    var method: Moya.Method { .post }
    var task: Moya.Task {
        switch self {
        case .requestToken(let token):
            return .requestParameters(parameters: ["token": token], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
}
