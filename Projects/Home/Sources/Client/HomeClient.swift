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
    var fetchShowToOpen: () async throws -> FetchToOpenShowResponseDTO
    var fetchShowToEnd: () async throws -> FetchShowToEndResponseDTO
    var fetchShowToCost: () async throws -> FetchShowCostShowResponseDTO
}

extension HomeClient: DependencyKey {
    static var liveValue = {
        Self(
            fetchShowRecommendations: fetchShowRecommendations,
            fetchShowTop10: fetchShowTop10,
            fetchShowToOpen: fetchShowToOpen,
            fetchShowToEnd: fetchShowToEnd,
            fetchShowToCost: fetchShowToCost
        )
    }()
    
    static func fetchShowRecommendations() async throws -> FetchShowRecomandationResponseDTO {
        return try await MoyaProvider<HomeAPI>().request(.fetchShowRecommendations)
    }
    
    static func fetchShowTop10() async throws -> FetchShowTop10ResponseDTO {
        return try await MoyaProvider<HomeAPI>().request(.fetchShowTop10)
    }
    
    static func fetchShowToOpen() async throws -> FetchToOpenShowResponseDTO {
        return try await MoyaProvider<HomeAPI>().request(.fetchShowToOpen)
    }
    
    static func fetchShowToEnd() async throws -> FetchShowToEndResponseDTO {
        return try await MoyaProvider<HomeAPI>().request(.fetchShowToEnd)
    }
    
    static func fetchShowToCost() async throws -> FetchShowCostShowResponseDTO {
        return try await MoyaProvider<HomeAPI>().request(.fetchShowToCost)
    }
}

extension DependencyValues {
    var homeClient: HomeClient {
        get { self[HomeClient.self] }
        set { self[HomeClient.self] = newValue }
    }
}
