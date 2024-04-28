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
}

extension HomeClient: DependencyKey {
    static var liveValue = {
        Self(
            fetchShowRecommendations: fetchShowRecommendations
        )
    }()
    
    static func fetchShowRecommendations() async throws -> FetchShowRecomandationResponseDTO {
        return try await MoyaProvider<HomeAPI>().request(.fetchShowRecommendations)
    }
}

extension DependencyValues {
    var homeClient: HomeClient {
        get { self[HomeClient.self] }
        set { self[HomeClient.self] = newValue }
    }
}
