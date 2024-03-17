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
    case createReview(body: CreateReviewBody)
}

extension ReviewAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    var path: String {
        switch self {
        case .fetchReviewList(let id, _):
            return "/shows/\(id)/reviews"
        case .createReview:
            return "/review"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fetchReviewList: return .get
        case .createReview: return .post
        }
        
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .fetchReviewList(_, let sort):
            param.updateValue(sort.APIName, forKey: "sort")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .createReview(let body):
            return .requestJSONEncodable(body)
        }
    }
    
    var headers: [String : String]? {
        var header: [String: String] = [:]
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue) ?? ""
        header.updateValue("Bearer \(accessToken)", forKey: "Authorization")
        return header
    }
}
