//
//  ReviewFeature.swift
//  Review
//
//  Created by 김민석 on 3/16/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ReviewFeature {
    public init() { }
    
    public enum SortType: String {
        case createdAt
        case likeCount
        case grade
        
        var title: String {
            switch self {
            case .createdAt: return "최신순"
            case .likeCount: return "좋아요순"
            case .grade: return "별점순"
            }
        }
        
        var APIName: String {
            return self.rawValue
        }
    }
    
    public struct State: Equatable {
        public init(showInfo: ReviewWriteViewComponents) {
            self.showInfo = showInfo
        }
        let showInfo: ReviewWriteViewComponents
        var reviewList: [FetchReviewListResult] = []
    }
    
    public enum Action {
        case fetchReviewList(sort: SortType)
        case responseReviewList([FetchReviewListResult])
        case didTappedReviewWriteButton(ReviewWriteViewComponents)
        case didTappedReviewList(showInfo: ReviewWriteViewComponents)
    }
    
    @Dependency(\.reviewClient) var reviewClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchReviewList(let sort):
                return .run { [id = state.showInfo.showId] send in
                    do {
                        try await send(.responseReviewList(reviewClient.fetchReviewList(id, sort).content))
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            case .responseReviewList(let response):
                state.reviewList = response
                return .none
            case .didTappedReviewWriteButton:
                return .none
            case .didTappedReviewList:
                return .none
            }
        }
    }
    
}
