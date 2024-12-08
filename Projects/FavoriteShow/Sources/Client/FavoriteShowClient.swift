//
//  FavoriteShowClient.swift
//  FavoriteShow
//
//  Created by 김민석 on 12/8/24.
//

import Foundation

import ComposableArchitecture
import Moya

public struct FavoriteShowClient {
    public var fetchFavoriteShowList: () async throws -> FetchFavoriteShowListResponseDTO
    public var putFavoriteShow: (String) async throws -> Bool
    public var deleteFavoriteShow: (String) async throws -> Bool
    public var fetchIsFavoriteShow: (String) async throws -> FetchIsFavoriteShowResponseDTO
}

extension FavoriteShowClient: DependencyKey {
    public static var liveValue = {
        Self(
            fetchFavoriteShowList: fetchFavoriteShowList,
            putFavoriteShow: putFavoriteShow(id:),
            deleteFavoriteShow: deleteFavoriteShow(id:),
            fetchIsFavoriteShow: fetchIsFavoriteShow(id:)
        )
    }()
    
    public static func fetchFavoriteShowList() async throws -> FetchFavoriteShowListResponseDTO {
        return try await MoyaProvider<FavoriteShowAPI>().request(.fetchFavoriteShow)
    }
    
    public static func putFavoriteShow(id: String) async throws -> Bool {
        return try await MoyaProvider<FavoriteShowAPI>().request(.putFavoriteShow(id: id))
    }
    
    public static func deleteFavoriteShow(id: String) async throws -> Bool {
        return try await MoyaProvider<FavoriteShowAPI>().request(.deleteFavoriteShow(id: id))
    }
    
    static func fetchIsFavoriteShow(id: String) async throws -> FetchIsFavoriteShowResponseDTO {
        return try await MoyaProvider<FavoriteShowAPI>().request(.fetchIsFavoriteShow(id: id))
    }
}

extension DependencyValues {
    public var favoriteShowClient: FavoriteShowClient {
        get { self[FavoriteShowClient.self] }
        set { self[FavoriteShowClient.self] = newValue }
    }
}
