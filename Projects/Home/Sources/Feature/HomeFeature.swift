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
        var showTop10: [FetchShowTop10Result] = []
        var showToOpen: [FetchToOpenShowResult] = []
        var showToEnd: [FetchShowToEndResult] = []
    }
    
    @Dependency (\.homeClient) var homeClient
    
    public enum Action {
        case fetchShowRecommendations
        case showRecommendationsResponse([FetchShowRecomandationResponseResult])
        case showRecommendationsError(Error)
        case fetchShowTop10
        case showTop10Response([FetchShowTop10Result])
        case showTop10Error(Error)
        case fetchToOpenShow
        case toOpenShowResponse([FetchToOpenShowResult])
        case toOpenShowError(Error)
        case fetchToEndShow
        case toEndShowReseponse([FetchShowToEndResult])
        case toEndShowError(Error)
        case didTappedShow(id: String)
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
            case .fetchShowTop10:
                return .run { send in
                    do {
                        try await send(.showTop10Response(homeClient.fetchShowTop10().content))
                    } catch {
                        await send(.showTop10Error(error))
                    }
                }
            case .showTop10Response(let response):
                state.showTop10 = response.suffix(10)
                return .none
            case .showTop10Error(let error):
                print(error.localizedDescription)
                return .none
            case .fetchToOpenShow:
                return .run { send in
                    do {
                        try await send(.toOpenShowResponse(homeClient.fetchShowToOpen().content))
                    } catch {
                        await send(.toOpenShowError(error))
                    }
                }
            case .toOpenShowResponse(let response):
                state.showToOpen = response
                return .none
            case .toOpenShowError(let error):
                print(error.localizedDescription)
                return .none
            case .fetchToEndShow:
                return .run { send in
                    do {
                        try await send(.toEndShowReseponse(homeClient.fetchShowToEnd().content))
                    } catch {
                        await send(.toEndShowError(error))
                    }
                }
            case .toEndShowReseponse(let response):
                state.showToEnd = response
                return .none
            case .toEndShowError(let error):
                print(error.localizedDescription)
                return .none
            case .didTappedShow:
                return .none
            }
        }
    }

}
