//
//  LiveTalkClient.swift
//  LiveTalk
//
//  Created by 김민석 on 12/29/24.
//

import Foundation

import ComposableArchitecture
import Moya
import StreamChat

struct LiveTalkClient {
    var fetchChatToken: () async throws -> FetchChatTokenResponseDTO
}

extension LiveTalkClient: DependencyKey {
    static var liveValue = {
        Self(fetchChatToken: fetchChatToken)
    }()
    
    static func fetchChatToken() async throws -> FetchChatTokenResponseDTO {
        return try await MoyaProvider<LiveTalkAPI>().request(.fetchChatToken)
    }
}

extension DependencyValues {
    var liveTalkClient: LiveTalkClient {
        get { self[LiveTalkClient.self] }
        set { self[LiveTalkClient.self] = newValue }
    }
}
