//
//  ReviewClient.swift
//  Review
//
//  Created by 김민석 on 3/16/24.
//

import Foundation

import ComposableArchitecture
import Moya

struct ReviewClient {
    var fetchReviewList: (String, ReviewFeature.SortType) async throws -> FetchReviewListDTO
}

extension ReviewClient: DependencyKey {
    static var liveValue = {
        Self(fetchReviewList: fetchReviewList(id:sort:))
    }()
    
    static func fetchReviewList(id: String, sort: ReviewFeature.SortType) async throws -> FetchReviewListDTO {
        return try await MoyaProvider<ReviewAPI>().request(.fetchReviewList(id: id, sort: sort))
    }
}

extension DependencyValues {
    var reviewClient: ReviewClient {
        get { self[ReviewClient.self] }
        set { self[ReviewClient.self] = newValue }
    }
}
