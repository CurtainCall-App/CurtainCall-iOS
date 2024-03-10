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
    
    public enum ShowDetailCategoryType: String, CaseIterable {
        case detail = "상세 정보"
        case review = "공연 리뷰"
        case lostItem = "분실물"
    }
    
    public struct State: Equatable {
        public init(showId: String) {
            self.showId = showId
        }
        var showId: String
        var showInfo: ShowDetailResponseContent?
        var currentSelectedCategory: ShowDetailCategoryType = .detail
    }
    
    public enum Action {
        case fetchDetailResponse
        case showDetailResponse(ShowDetailResponseContent)
        case didTappedCategory(ShowDetailCategoryType)
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
            case .didTappedCategory(let type):
                state.currentSelectedCategory = type
                return .none
            }
        }
    }
}
