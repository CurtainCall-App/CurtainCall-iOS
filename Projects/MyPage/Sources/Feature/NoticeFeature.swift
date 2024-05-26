//
//  NoticeFeature.swift
//  MyPage
//
//  Created by 김민석 on 5/26/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct NoticeFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var noticeList: [FetchNoticeListResult] = []
    }
    
    public enum Action {
        case fetchNoticeList
        case noticeListResponse([FetchNoticeListResult])
        case noticeListError(Error)
    }
    
    @Dependency(\.noticeClient) var noticeClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchNoticeList:
                return .run { send in
                    do {
                        try await send(.noticeListResponse(noticeClient.fetchNoticeList().content))
                    } catch {
                        await send(.noticeListError(error))
                    }
                }
            case .noticeListResponse(let response):
                state.noticeList = response
                return .none
            case .noticeListError(let error):
                print(error.localizedDescription)
                return .none
            }
            
        }
    }
}

