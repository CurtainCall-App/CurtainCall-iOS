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
    case fetchShowSearchList(keyword: String)
    case fetchShowDetail(id: String)
    case fetchFavoriteShow
    case putFavoriteShow(id: String)
    case deleteFavoriteShow(id: String)
}

extension ShowAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")!.absoluteURL }
    var path: String {
        switch self {
        case .fetchShowList: return "/shows"
        case .fetchShowSearchList: return "/search/shows"
        case .fetchShowDetail(let id): return "/shows/\(id)"
        case .fetchFavoriteShow:
            let memberId = UserDefaults.standard.integer(forKey: UserDefaultKeys.userId.rawValue)
            return "/members/\(memberId)/favorite"
        case .putFavoriteShow(let id): return "/shows/\(id)/favorite"
        case .deleteFavoriteShow(let id): return "/shows/\(id)/favorite"
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
        case .fetchShowList(let page, let genre, let sort):
            param.updateValue(page, forKey: "page")
            param.updateValue(genre.APIName, forKey: "genre")
            param.updateValue(sort.APIName, forKey: "sort")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .fetchShowSearchList(let keyword):
            param.updateValue(keyword, forKey: "keyword")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .fetchShowDetail: return .requestPlain
        case .fetchFavoriteShow: return .requestPlain
        case .putFavoriteShow: return .requestPlain
        case .deleteFavoriteShow: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchFavoriteShow: return Utils.authHeader
        case .putFavoriteShow: return Utils.authHeader
        case .deleteFavoriteShow: return Utils.authHeader
        default: return nil
        }
    }
}
