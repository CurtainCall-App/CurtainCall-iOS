//
//  FavoriteShowService.swift
//  FavoriteShow
//
//  Created by 김민석 on 12/8/24.
//

import Foundation

import Common

import Moya

enum FavoriteShowAPI {
    case fetchFavoriteShow
    case putFavoriteShow(id: String)
    case deleteFavoriteShow(id: String)
    case fetchIsFavoriteShow(id: String)
}

extension FavoriteShowAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    
    var path: String {
        switch self {
        case .fetchFavoriteShow:
            let memberId = UserDefaults.standard.integer(forKey: UserDefaultKeys.userId.rawValue)
            return "/members/\(memberId)/favorite"
        case .putFavoriteShow(let id): return "/shows/\(id)/favorite"
        case .deleteFavoriteShow(let id): return "/shows/\(id)/favorite"
        case .fetchIsFavoriteShow:
            return "/member/favorite"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .putFavoriteShow: return .put
        case .deleteFavoriteShow: return .delete
        default: return .get
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {

        case .fetchFavoriteShow: return .requestPlain
        case .putFavoriteShow: return .requestPlain
        case .deleteFavoriteShow: return .requestPlain
        case .fetchIsFavoriteShow(let id):
            param.updateValue(id, forKey: "showIds")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return Utils.authHeader
    }
}
