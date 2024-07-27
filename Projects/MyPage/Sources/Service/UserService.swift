//
//  UserService.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

import Common
import Moya

enum UserAPI {
    case fetchUserInfo(id: Int)
    case deleteAccount(body: DeleteAccountBody)
    case saveData(data: Data)
    case updateUserInfo(nickname: String?, imageID: Int?)
}

extension UserAPI: TargetType {
    var baseURL: URL { URL(string: "\(Secret.BASE_URL)")! }
    
    var path: String {
        switch self {
        case .fetchUserInfo(let id): return "members/\(id)"
        case .deleteAccount: return "/member"
        case .saveData: return "/images"
        case .updateUserInfo: return "/member"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUserInfo: return .get
        case .deleteAccount: return .delete
        case .saveData: return .post
        case .updateUserInfo: return .patch
        }
        
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchUserInfo: return .requestPlain
        case .deleteAccount(let body):
            return .requestJSONEncodable(body)
        case .saveData(let data):
            let formData = [MultipartFormData(provider: .data(data), name: "image", fileName: "\(UUID().uuidString).jpg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        case .updateUserInfo(let nickname, let imageID):
            var params: [String: Any] = [:]
            if let nickname { params.updateValue(nickname, forKey: "nickname") }
            if let imageID { params.updateValue(imageID, forKey: "imageId")}
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return Utils.authHeader
    }
    
    
}

