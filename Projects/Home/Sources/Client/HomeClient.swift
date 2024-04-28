//
//  HomeClient.swift
//  Home
//
//  Created by 김민석 on 4/28/24.
//

import Foundation

import ComposableArchitecture
import Moya

struct HomeClient {
    var fetchShowRecommendations: () async throws -> FetchShowRecomandationResponseDTO
    var fetchShowTop10: () async throws -> FetchShowTop10ResponseDTO
}

extension HomeClient: DependencyKey {
    static var liveValue = {
        Self(
            fetchShowRecommendations: fetchShowRecommendations,
            fetchShowTop10: fetchShowTop10
        )
    }()
    
    static func fetchShowRecommendations() async throws -> FetchShowRecomandationResponseDTO {
        return try await MoyaProvider<HomeAPI>().request(.fetchShowRecommendations)
    }
    
    static func fetchShowTop10() async throws -> FetchShowTop10ResponseDTO {
        return try await MoyaProvider<HomeAPI>().request(.fetchShowTop10)
    }
}

extension DependencyValues {
    var homeClient: HomeClient {
        get { self[HomeClient.self] }
        set { self[HomeClient.self] = newValue }
    }
}
