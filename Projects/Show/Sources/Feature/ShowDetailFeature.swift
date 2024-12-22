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
    
    @ObservableState
    public struct State: Equatable {
        public init(showId: String) {
            self.showId = showId
        }
        var showId: String
        var showInfo: ShowDetailResponseContent?
        var currentSelectedCategory: ShowDetailCategoryType = .detail
        var facilityInfo: FetchFacilityResponseDTO?
        var detailImageHeight: CGFloat = 300
        var isLikeShow: Bool = false
        var review: ReviewFeature.State?
    }
    
    public enum Action {
        case fetchDetailResponse
        case showDetailResponse(ShowDetailResponseContent)
        case didTappedCategory(ShowDetailCategoryType)
        case fetchFacilityDetail(id: String)
        case facilityDetailResponse(FetchFacilityResponseDTO)
        case didTappedMoreDetailImage
        case fetchIsFavoriteShow
        case review(ReviewFeature.Action)
        case isFavoriteShowResponse(Bool)
        case failedToFetchIsLike(Error)
        case didTappedFaovorite
        case selectedFavorite
        case deselectedFavorite
        case isSucessSelectedFavorite(Bool)
        case isSucessDeselectedFavorite(Bool)
    }
    
    @Dependency (\.showClient) var showClient
    @Dependency (\.facilityClient) var facilityClient
    @Dependency (\.favoriteShowClient) var favoriteShowClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchDetailResponse:
                return .run { [id = state.showId] send in
                    do {
                        try await send(.showDetailResponse(showClient.fetchShowDetail(id)))
                        try await send(.fetchIsFavoriteShow)
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
                    let info = ReviewWriteViewComponents(
                        showId: state.showInfo?.id ?? "",
                        showImage: state.showInfo?.poster ?? "",
                        showName: state.showInfo?.name ?? "",
                        genre: state.showInfo?.genre ?? .play)
                    
                    state.review = .init(showInfo: info)
                }
                return .none
                
            case .fetchFacilityDetail(let id):
                return .run { send in
                    do {
                        try await send(.facilityDetailResponse(facilityClient.fetchFacilityDetail(id)))
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
            case .fetchIsFavoriteShow:
                return .run { [id = state.showId] send in
                    do {
                        try await send(.isFavoriteShowResponse(favoriteShowClient.fetchIsFavoriteShow(id).content.first?.favorite ?? false))
                    } catch {
                        await send(.failedToFetchIsLike(error))
                    }
                }
            case .isFavoriteShowResponse(let isFavorite):
                state.isLikeShow = isFavorite
                return .none
            case .failedToFetchIsLike(let error):
                print(error.localizedDescription)
                return .none
            case .review:
                return .none
            case .didTappedFaovorite:
                return .run { [isFavorite = state.isLikeShow ] send in
                    if isFavorite {
                        await send(.deselectedFavorite)
                    } else {
                        await send(.selectedFavorite)
                    }
                }
            case .selectedFavorite:
                return .run { [showId = state.showId] send in
                    do {
                        try await send(.isSucessSelectedFavorite(favoriteShowClient.putFavoriteShow(showId)))
                    } catch {
                        await send(.isSucessSelectedFavorite(false))
                    }
                }
            case .deselectedFavorite:
                return .run { [showId = state.showId] send in
                    do {
                        try await send(.isSucessDeselectedFavorite(favoriteShowClient.deleteFavoriteShow(showId)))
                    } catch {
                        await send(.isSucessDeselectedFavorite(false))
                    }
                }
            case .isSucessSelectedFavorite(let isSuccess):
                guard isSuccess else { return .none }
                return .run { send in
                    await send(.fetchDetailResponse)
                }
            case .isSucessDeselectedFavorite(let isSuccess):
                guard isSuccess else { return .none }
                return .run { send in
                    await send(.fetchDetailResponse)
                }
            }
        }
        .ifLet(\.review, action: \.review) {
            ReviewFeature()
        }
    }
}
