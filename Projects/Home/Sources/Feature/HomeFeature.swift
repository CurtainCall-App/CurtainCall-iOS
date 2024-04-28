//
//  HomeFeature.swift
//  Home
//
//  Created by 김민석 on 2/22/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct HomeFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var showRecommendations: [FetchShowRecomandationResponseResult] = []
    }
    
    @Dependency (\.homeClient) var homeClient
    
    public enum Action {
        case fetchShowRecommendations
        case showRecommendationsResponse([FetchShowRecomandationResponseResult])
        case showRecommendationsError(Error)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchShowRecommendations:
                return .run { send in
                    do {
                        try await send(.showRecommendationsResponse(homeClient.fetchShowRecommendations().content))
                    } catch {
                        await send(.showRecommendationsError(error))
                    }
                }
            case .showRecommendationsResponse(let response):
                state.showRecommendations = response
                return .none
            case .showRecommendationsError(let error):
                print(error.localizedDescription)
                return .none
            }
        }
    }
}
