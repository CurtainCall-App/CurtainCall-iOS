//
//  ShowDetailFeature.swift
//  Show
//
//  Created by 김민석 on 3/3/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ShowDetailFeature {
    public init() { }
    
    public struct State: Equatable {
        public init(showId: String) {
            self.showId = showId
        }
        var showId: String
        var showInfo: ShowDetailResponseContent?
    }
    
    public enum Action {
        case fetchDetailResponse
        case showDetailResponse(ShowDetailResponseContent)
    }
    
    @Dependency (\.showClient) var showClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchDetailResponse:
                return .run { [id = state.showId] send in
                    do {
                        try await send(.showDetailResponse(showClient.fetchShowDetail(id)))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .showDetailResponse(let response):
                state.showInfo = response
                return .none
            }
        }
    }
}
