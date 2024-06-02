//
//  NoticeClient.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import Foundation

import Moya
import ComposableArchitecture

struct NoticeClient {
    var fetchNoticeList: () async throws -> FetchNoticeListResponseDTO
    var fetchNoticeDetail: (Int) async throws -> FetchNoticeDetailResponseDTO
}

extension NoticeClient: DependencyKey {
    static var liveValue: NoticeClient = {
        Self(
            fetchNoticeList: fetchNoticeList,
            fetchNoticeDetail: fetchNoticeDetail(id:)
        )
    }()
    
    static func fetchNoticeList() async throws -> FetchNoticeListResponseDTO {
        return try await MoyaProvider<NoticeAPI>().request(.fetchNotice)
    }
    
    static func fetchNoticeDetail(id: Int) async throws -> FetchNoticeDetailResponseDTO {
        return try await MoyaProvider<NoticeAPI>().request(.fetchNoticeDetail(id: id))
    }
}

extension DependencyValues {
    var noticeClient: NoticeClient {
        get { self[NoticeClient.self] }
        set { self[NoticeClient.self] = newValue }
    }
}
