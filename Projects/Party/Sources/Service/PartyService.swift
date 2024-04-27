//
//  PartyService.swift
//  Party
//
//  Created by 김민석 on 4/10/24.
//

import Foundation

import Common

import Moya

enum PartyAPI {
    case fetchPartyList(page: Int, startDate: String, endDate: String)
    case createParty(body: CreatePartyBody)
}

extension PartyAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    var path: String {
        switch self {
        case .fetchPartyList: return "/parties"
        case .createParty: return "/parties"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fetchPartyList: return .get
        case .createParty: return .post
        }
    }
    
    var task: Moya.Task {
        var param: [String: Any] = [:]
        switch self {
        case .fetchPartyList(let page, let startDate, let endDate):
            param.updateValue(page, forKey: "page")
            param.updateValue(20, forKey: "size")
            param.updateValue(startDate, forKey: "startDate")
            param.updateValue(endDate, forKey: "endDate")
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .createParty(let body):
            return .requestJSONEncodable(body)
        }
    }
    
    var headers: [String : String]? {
        return Utils.authHeader
    }
}
