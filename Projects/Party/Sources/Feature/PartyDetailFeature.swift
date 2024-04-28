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
        var isParticipated: Bool = false
    }
    
    @Dependency (\.partyClient) var partyClient
    
    public enum Action {
        case fetchPartyDetail
        case fetchDidParticipated
        case checkParticipated(Bool)
        case successPartyDetailResponse(FetchPartyDetailResponseDTO)
        case failToPartyDetailResponse(Error)
        case didTappedParticipateButton
        case putParticipateResponse(Bool)
        case putParticipateError(Error)
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
            case .fetchDidParticipated:
                return .run { [id = state.id] send in
                    do {
                        try await send(.checkParticipated(partyClient.fetchDidParticipated(id).content.first?.participated ?? false))
                    } catch {
                        await send(.checkParticipated(false))
                    }
                }
            case .didTappedParticipateButton:
                return .run { [id = state.id] send in
                    do {
                        try await send(.putParticipateResponse(partyClient.putParticipate(id)))
                    } catch {
                        await send(.putParticipateError(error))
                    }
                }
            case .checkParticipated(let check):
                state.isParticipated = check
                return .none
            case .successPartyDetailResponse(let response):
                state.partyDetailInfo = response
                return .none
            case .failToPartyDetailResponse(let error):
                return .none
            case .putParticipateResponse(let check):
                state.isParticipated = check
                return .none
            case .putParticipateError(let error):
                return .none
            }
        }
    }
}

