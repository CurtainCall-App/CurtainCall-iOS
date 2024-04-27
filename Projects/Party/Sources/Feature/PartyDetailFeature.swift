//
//  PartyDetailFeature.swift
//  Party
//
//  Created by 김민석 on 4/27/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct PartyDetailFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init(id: Int) { 
            self.id = id
        }
        let id: Int
        var partyDetailInfo: FetchPartyDetailResponseDTO?
    }
    
    @Dependency (\.partyClient) var partyClient
    
    public enum Action {
        case fetchPartyDetail
        case successPartyDetailResponse(FetchPartyDetailResponseDTO)
        case failToPartyDetailResponse(Error)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchPartyDetail:
                return .run { [id = state.id] send in
                    do {
                        try await send(.successPartyDetailResponse(partyClient.fetchPartyDetail(id)))
                    } catch {
                        await send(.failToPartyDetailResponse(error))
                    }
                }
            case .successPartyDetailResponse(let response):
                state.partyDetailInfo = response
                return .none
            case .failToPartyDetailResponse(let error):
                return .none
            }
        }
    }
}

