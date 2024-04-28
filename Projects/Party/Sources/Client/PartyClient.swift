//
//  PartyClient.swift
//  Party
//
//  Created by 김민석 on 4/10/24.
//

import Foundation

import Common
import ComposableArchitecture
import Moya

struct PartyClient {
    var fetchPartyList: (Int, Date, Date) async throws ->  FetchPartyListResponseDTO
    var createParty: (CreatePartyBody) async throws -> CreatePartyResponseDTO
    var fetchPartyDetail: (Int) async throws -> FetchPartyDetailResponseDTO
    var fetchDidParticipated: (Int) async throws -> FetchDidParticipatedResponseDTO
}

extension PartyClient: DependencyKey {
    static var liveValue = {
        Self(fetchPartyList: fetchPartyList, 
             createParty: createParty,
             fetchPartyDetail: fetchPartyDetail,
             fetchDidParticipated: fetchDidParticipated
        )
    }()
    
    static func fetchPartyList(page: Int, startDate: Date, endDate: Date) async throws -> FetchPartyListResponseDTO {
        return try await MoyaProvider<PartyAPI>()
            .request(.fetchPartyList(
                page: page,
                startDate: Utils.convertDateToAPIString(date: startDate),
                endDate: Utils.convertDateToAPIString(date: endDate))
            )
    }
    
    static func createParty(body: CreatePartyBody) async throws -> CreatePartyResponseDTO {
        return try await MoyaProvider<PartyAPI>()
            .request(.createParty(body: body))
    }
    
    static func fetchPartyDetail(id: Int) async throws -> FetchPartyDetailResponseDTO {
        return try await MoyaProvider<PartyAPI>()
            .request(.fetchPartyDetail(id: id))
    }
    
    static func fetchDidParticipated(id: Int) async throws -> FetchDidParticipatedResponseDTO {
        return try await MoyaProvider<PartyAPI>()
            .request(.fetchDidParticipated(id: id))
    }
}

extension DependencyValues {
    var partyClient: PartyClient {
        get { self[PartyClient.self] }
        set { self[PartyClient.self] = newValue }
    }
}
