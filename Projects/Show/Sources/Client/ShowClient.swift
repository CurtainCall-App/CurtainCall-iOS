//
//  ShowClient.swift
//  Show
//
//  Created by 김민석 on 2/25/24.
//

import Foundation

import ComposableArchitecture
import Moya

public struct ShowClient {
    public var fetchShowList: (Int, ShowFeature.ShowType, ShowSortFeature.CategoryType) async throws -> FetchShowResponseDTO
    var fetchShowSearchList: (String) async throws -> FetchShowResponseDTO
    var fetchShowDetail: (String) async throws -> ShowDetailResponseContent
}

extension ShowClient: DependencyKey {
    public static var liveValue = {
        Self(
            fetchShowList: fetchShowList,
            fetchShowSearchList: fetchShowSearchList(keyword:),
            fetchShowDetail: fetchShowDetail(id:)
        )
    }()
    
    public static func fetchShowList(page: Int, genre: ShowFeature.ShowType, sort: ShowSortFeature.CategoryType) async throws -> FetchShowResponseDTO {
        return try await MoyaProvider<ShowAPI>().request(.fetchShowList(page: page, genre: genre, sort: sort))
    }
    
    public static func fetchShowSearchList(keyword: String) async throws -> FetchShowResponseDTO {
        return try await MoyaProvider<ShowAPI>().request(.fetchShowSearchList(keyword: keyword))
    }
    public static func fetchShowDetail(id: String) async throws -> ShowDetailResponseContent {
        return try await MoyaProvider<ShowAPI>().request(.fetchShowDetail(id: id))
    }
}

extension DependencyValues {
    public var showClient: ShowClient {
        get { self[ShowClient.self] }
        set { self[ShowClient.self] = newValue }
    }
}
