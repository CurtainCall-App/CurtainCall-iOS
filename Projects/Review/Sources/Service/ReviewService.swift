//
//  ReviewService.swift
//  Review
//
//  Created by 김민석 on 3/16/24.
//

import Foundation

import Common
import Moya

enum ReviewAPI {
    case fetchReviewList(id: String, sort: ReviewFeature.SortType)
}

extension ReviewAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    var path: String {
        switch self {
        case .fetchReviewList(let id, _):
            return "/shows/\(id)/reviews"
        }
    }
    var method: Moya.Method { .get }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .fetchReviewList(_, let sort):
            param.updateValue(sort.APIName, forKey: "sort")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var header: [String: String] = [:]
        header.updateValue(UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue) ?? "", forKey: "Authorization")
        return header
    }
}