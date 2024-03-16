//
//  FacilityClient.swift
//  Show
//
//  Created by 김민석 on 3/14/24.
//

import Foundation

import ComposableArchitecture
import Moya

struct FacilityClient {
    var fetchFacilityDetail: (String) async throws -> FetchFacilityResponseDTO
}

extension FacilityClient: DependencyKey {
    static var liveValue = {
        Self(fetchFacilityDetail: fetchFacilityDetail)
    }()
    
    static func fetchFacilityDetail(id: String) async throws -> FetchFacilityResponseDTO {
        return try await MoyaProvider<FacilityAPI>().request(.fetchDetail(id: id))
    }
}

extension DependencyValues {
    var facilityClient: FacilityClient {
        get { self[FacilityClient.self] }
        set { self[FacilityClient.self] = newValue }
    }
}
