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
        public init(showInfo: ReviewWriteViewComponents) {
            self.showInfo = showInfo
        }
        let showInfo: ReviewWriteViewComponents
        var reviewList: [FetchReviewListResult] = []
        var selectedCategory: ReviewFeature.SortType = .createdAt
    }
    
    public enum Action {
        case fetchReviewList
        case responseReviewList([FetchReviewListResult])
        case didTappedCreateReview(showInfo: ReviewWriteViewComponents)
    }
    
    @Dependency(\.reviewClient) var reviewClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchReviewList:
                return .run { [
                    id = state.showInfo.showId,
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
            case .didTappedCreateReview:
                return .none
            }
        }
    }
}
