//
//  LiveTalkService.swift
//  LiveTalk
//
//  Created by 김민석 on 12/29/24.
//

import Foundation

import Common

import Moya

enum LiveTalkAPI {
    case fetchChatToken
}

extension LiveTalkAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .fetchChatToken: return "/chat-token"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Moya.Task { .requestPlain }
    
    var headers: [String : String]? { Utils.authHeader }
    
}
