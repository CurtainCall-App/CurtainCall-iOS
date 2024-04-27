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
}

extension PartyClient: DependencyKey {
    static var liveValue = {
        Self(fetchPartyList: fetchPartyList, createParty: createParty)
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
}

extension DependencyValues {
    var partyClient: PartyClient {
        get { self[PartyClient.self] }
        set { self[PartyClient.self] = newValue }
    }
}
