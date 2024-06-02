//
//  NoticeDetailFeature.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct NoticeDetailFeature {
    
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init(id: Int) {
            self.id = id
        }
        let id: Int
        var noticeDetailInfo: FetchNoticeDetailResponseDTO?
    }
    
    public enum Action {
        case fetchNoticeDetail
        case noticeDetailResponse(FetchNoticeDetailResponseDTO)
        case noticeDetailError(Error)
    }
    
    @Dependency(\.noticeClient) var noticeClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchNoticeDetail:
                return .run { [id = state.id] send in
                    do {
                        try await send(.noticeDetailResponse(noticeClient.fetchNoticeDetail(id)))
                    } catch {
                        await send(.noticeDetailError(error))
                    }
                }
            case .noticeDetailResponse(let response):
                state.noticeDetailInfo = response
                return .none
            case .noticeDetailError(let error):
                print(error.localizedDescription)
                return .none
            }
        }
    }
}

