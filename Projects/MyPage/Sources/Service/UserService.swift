//
//  UserService.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

import Common
import Moya

enum UserAPI {
    case fetchUserInfo(id: Int)
    case deleteAccount(body: DeleteAccountBody)
}

extension UserAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    
    var path: String {
        switch self {
        case .fetchUserInfo(let id): return "members/\(id)"
        case .deleteAccount: return "/member"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUserInfo: return .get
        case .deleteAccount: return .delete
        }
        
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchUserInfo: return .requestPlain
        case .deleteAccount(let body):
            return .requestJSONEncodable(body)
        }
    }
    
    var headers: [String : String]? {
        return Utils.authHeader
    }
    
    
}

