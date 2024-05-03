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
    case fetchShowTop10
    case fetchShowToOpen
    case fetchShowToEnd
}

extension HomeAPI: TargetType {
    var baseURL: URL { URL(string: Secret.BASE_URL)! }
    
    var path: String {
        switch self {
        case .fetchShowRecommendations: return "/show-recommendations"
        case .fetchShowTop10: return "/box-office"
        case .fetchShowToOpen: return "/shows-to-open"
        case .fetchShowToEnd: return "/shows-to-end"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchShowRecommendations: return .get
        case .fetchShowTop10: return .get
        case .fetchShowToOpen: return .get
        case .fetchShowToEnd: return .get
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .fetchShowRecommendations: return .requestPlain
        case .fetchShowTop10:
            param.updateValue("WEEK", forKey: "type")
            param.updateValue(Utils.convertDateToAPIString(date: Date()), forKey: "baseDate")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .fetchShowToOpen:
            param.updateValue(0, forKey: "page")
            param.updateValue(Utils.convertDateToAPIString(date: Date()), forKey: "startDate")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .fetchShowToEnd:
            param.updateValue(0, forKey: "page")
            param.updateValue(Utils.convertDateToAPIString(date: Date()), forKey: "endDate")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
    
    
}
