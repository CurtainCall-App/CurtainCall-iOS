//
//  ReviewListFeature.swift
//  Review
//
//  Created by 김민석 on 3/24/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ReviewListFeature {
    public init() { }
    
    public struct State: Equatable {
        public init(showId: String) {
            self.showId = showId
        }
        let showId: String
        var reviewList: [FetchReviewListResult] = []
        var selectedCategory: ReviewFeature.SortType = .likeCount
    }
    
    public enum Action {
        case fetchReviewList(sort: ReviewFeature.SortType)
        case responseReviewList([FetchReviewListResult])
    }
    
    @Dependency(\.reviewClient) var reviewClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchReviewList:
                return .run { [
                    id = state.showId,
                    sort = state.selectedCategory
                ] send in
                    do {
                        try await send(.responseReviewList(reviewClient.fetchReviewList(id, sort).content))
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            case .responseReviewList(let response):
                state.reviewList = response
                return .none
            }
        }
    }
}
