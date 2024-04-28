//
//  HomeService.swift
//  Home
//
//  Created by 김민석 on 4/28/24.
//

import Foundation

import Common

import Moya

enum HomeAPI {
    case fetchShowRecommendations
}

extension HomeAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .fetchShowRecommendations: return "/show-recommendations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchShowRecommendations: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchShowRecommendations: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        Utils.authHeader
    }
    
    
}
