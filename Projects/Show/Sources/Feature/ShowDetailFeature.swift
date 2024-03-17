//
//  ShowDetailFeature.swift
//  Show
//
//  Created by 김민석 on 3/3/24.
//

import Foundation

import Review

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
        var facilityInfo: FetchFacilityResponseDTO?
        var detailImageHeight: CGFloat = 300
        var review: ReviewFeature.State?
    }
    
    public enum Action {
        case fetchDetailResponse
        case showDetailResponse(ShowDetailResponseContent)
        case didTappedCategory(ShowDetailCategoryType)
        case fetchFacilityDetail(id: String)
        case facilityDetailResponse(FetchFacilityResponseDTO)
        case didTappedMoreDetailImage
        case review(ReviewFeature.Action)
    }
    
    @Dependency (\.showClient) var showClient
    @Dependency (\.facilityClient) var fetchClient
    
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
                return .run { send in
                    await send(.fetchFacilityDetail(id: response.facilityId))
                }
                
            case .didTappedCategory(let type):
                state.currentSelectedCategory = type
                if type == .review {
                    state.review = .init(showId: state.showInfo?.id ?? "")
                }
                return .none
                
            case .fetchFacilityDetail(let id):
                return .run { send in
                    do {
                        try await send(.facilityDetailResponse(fetchClient.fetchFacilityDetail(id)))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .facilityDetailResponse(let response):
                state.facilityInfo = response
                return .none
            case .didTappedMoreDetailImage:
                state.detailImageHeight = state.detailImageHeight == 300 ? .infinity: 300
                return .none
            case .review:
                return .none
            }
        }
        .ifLet(\.review, action: \.review) {
            ReviewFeature()
        }
    }
}
