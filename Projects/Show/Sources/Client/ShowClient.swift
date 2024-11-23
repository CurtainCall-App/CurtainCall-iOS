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
    var fetchFavoriteShowList: () async throws -> FetchFavoriteShowListResponseDTO
    var putFavoriteShow: (String) async throws -> Bool
    var deleteFavoriteShow: (String) async throws -> Bool
    var fetchIsFavoriteShow: (String) async throws -> FetchIsFavoriteShowResponseDTO
}

extension ShowClient: DependencyKey {
    public static var liveValue = {
        Self(
            fetchShowList: fetchShowList,
            fetchShowSearchList: fetchShowSearchList(keyword:),
            fetchShowDetail: fetchShowDetail(id:),
            fetchFavoriteShowList: fetchFavoriteShowList,
            putFavoriteShow: putFavoriteShow(id:),
            deleteFavoriteShow: deleteFavoriteShow(id:),
            fetchIsFavoriteShow: fetchIsFavoriteShow(id:)
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
    
    public static func fetchFavoriteShowList() async throws -> FetchFavoriteShowListResponseDTO {
        return try await MoyaProvider<ShowAPI>().request(.fetchFavoriteShow)
    }
    
    public static func putFavoriteShow(id: String) async throws -> Bool {
        return try await MoyaProvider<ShowAPI>().request(.putFavoriteShow(id: id))
    }
    
    public static func deleteFavoriteShow(id: String) async throws -> Bool {
        return try await MoyaProvider<ShowAPI>().request(.deleteFavoriteShow(id: id))
    }
    
    static func fetchIsFavoriteShow(id: String) async throws -> FetchIsFavoriteShowResponseDTO {
        return try await MoyaProvider<ShowAPI>().request(.fetchIsFavoriteShow(id: id))
    }
}

extension DependencyValues {
    public var showClient: ShowClient {
        get { self[ShowClient.self] }
        set { self[ShowClient.self] = newValue }
    }
}
