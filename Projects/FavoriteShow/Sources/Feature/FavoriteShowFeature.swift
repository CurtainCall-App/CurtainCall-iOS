//
//  FavoriteShowFeature.swift
//  FavoriteShow
//
//  Created by 김민석 on 12/8/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct FavoriteShowFeature {
    
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var selectedShowType: Genre = .play
        var showList: [FetchFavoriteShowListContent] = []
    }
    
    public enum Action {
        case fetchFavoriteShowList
        case failedToFavoriteList(Error)
        case showFavoriteListResponse(FetchFavoriteShowListResponseDTO)
        case didTappedShowType(Genre)
        case didTappedFavorite(id: String)
        case didTappedShow(id: String)
    }
    
    @Dependency (\.favoriteShowClient) var client
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchFavoriteShowList:
                return .run { send in
                    do {
                        try await send(.showFavoriteListResponse(client.fetchFavoriteShowList()))
                    } catch {
                        await send(.failedToFavoriteList(error))
                    }
                }
            case .showFavoriteListResponse(let response):
                state.showList = response.content.filter { $0.genre == state.selectedShowType }
                return .none
            case .failedToFavoriteList(let error):
                print(error.localizedDescription)
                return .none
            case .didTappedShowType(let type):
                state.selectedShowType = type
                return .run { send in
                    await send(.fetchFavoriteShowList)
                }
            case .didTappedFavorite(let id):
                return .run { send in
                    let isSuccess = try await client.deleteFavoriteShow(id)
                    if isSuccess {
                        await send(.fetchFavoriteShowList)
                    }
                }
            case .didTappedShow:
                return .none
            }
        }
    }
}

