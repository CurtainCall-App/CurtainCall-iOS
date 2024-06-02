//
//  NoticeAPI.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import Foundation

import Common
import Moya

enum NoticeAPI {
    case fetchNotice
    case fetchNoticeDetail(id: Int)
}

extension NoticeAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    
    var path: String {
        switch self {
        case .fetchNotice: return "/notices"
        case .fetchNoticeDetail(let id): return "/notices/\(id)"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
