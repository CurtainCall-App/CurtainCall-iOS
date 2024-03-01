//
//  ShowClient.swift
//  Show
//
//  Created by 김민석 on 2/25/24.
//

import Foundation

import ComposableArchitecture
import Moya

struct ShowClient {
    var fetchShowList: (Int, ShowFeature.ShowType, ShowSortFeature.CategoryType) async throws -> FetchShowResponseDTO
    var fetchShowSearchList: (String) async throws -> FetchShowResponseDTO
}

extension ShowClient: DependencyKey {
    static var liveValue = {
        Self(
            fetchShowList: fetchShowList,
            fetchShowSearchList: fetchShowSearchList(keyword:)
        )
    }()
    
    static func fetchShowList(page: Int, genre: ShowFeature.ShowType, sort: ShowSortFeature.CategoryType) async throws -> FetchShowResponseDTO {
        return try await MoyaProvider<ShowAPI>().request(.fetchShowList(page: page, genre: genre, sort: sort))
    }
    
    static func fetchShowSearchList(keyword: String) async throws -> FetchShowResponseDTO {
        return try await MoyaProvider<ShowAPI>().request(.fetchShowSearchList(keyword: keyword))
    }
}

extension DependencyValues {
    var showClient: ShowClient {
        get { self[ShowClient.self] }
        set { self[ShowClient.self] = newValue }
    }
}
