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
}

extension PartyClient: DependencyKey {
    static var liveValue = {
        Self(fetchPartyList: fetchPartyList)
    }()
    
    static func fetchPartyList(page: Int, startDate: Date, endDate: Date) async throws -> FetchPartyListResponseDTO {
        return try await MoyaProvider<PartyAPI>()
            .request(.fetchPartyList(
                page: page,
                startDate: Utils.convertDateToAPIString(date: startDate),
                endDate: Utils.convertDateToAPIString(date: endDate))
            )
    }
}

extension DependencyValues {
    var partyClient: PartyClient {
        get { self[PartyClient.self] }
        set { self[PartyClient.self] = newValue }
    }
}
