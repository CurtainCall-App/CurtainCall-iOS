//
//  DeleteAccountService.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

import Common
import Moya

enum DeleteAccountAPI {
    case deleteAccount(body: DeleteAccountBody)
}

extension DeleteAccountAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    
    var path: String {
        switch self {
        case .deleteAccount: return "/member"
        }
    }
    
    var method: Moya.Method { .delete }
    
    var task: Moya.Task {
        switch self {
        case .deleteAccount(let body):
            return .requestJSONEncodable(body)
        }
    }
    
    var headers: [String : String]? {
        return Utils.authHeader
    }
    
    
}

