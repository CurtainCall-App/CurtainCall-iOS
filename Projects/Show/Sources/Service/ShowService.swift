//
//  ShowService.swift
//  Show
//
//  Created by 김민석 on 2/25/24.
//

import Foundation

import Common

import Moya

enum ShowAPI {
    case fetchShowList(page: Int, genre: ShowFeature.ShowType, sort: ShowSortFeature.CategoryType)
}

extension ShowAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    var path: String { "/shows" }
    var method: Moya.Method { .get }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .fetchShowList(let page, let genre, let sort):
            param.updateValue(page, forKey: "page")
            param.updateValue(genre.APIName, forKey: "genre")
            param.updateValue(sort.APIName, forKey: "sort")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
}
