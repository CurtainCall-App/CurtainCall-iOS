//
//  FacilityService.swift
//  Show
//
//  Created by 김민석 on 3/10/24.
//

import Foundation

import Common

import Moya

enum FacilityAPI {
    case fetchDetail(id: String)
}

extension FacilityAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    var path: String {
        switch self {
        case .fetchDetail(let id):
            return "/facilities/\(id)"
        }
    }
    var method: Moya.Method { .get }
    
    var task: Moya.Task {
        switch self {
        case .fetchDetail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { nil }
}
