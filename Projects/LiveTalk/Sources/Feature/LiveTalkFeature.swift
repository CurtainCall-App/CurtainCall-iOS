//
//  LiveTalkFeature.swift
//  LiveTalk
//
//  Created by 김민석 on 12/22/24.
//

import Foundation

import Common

import ComposableArchitecture
import StreamChat

@Reducer
public struct LiveTalkFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
    }
    
    @Dependency (\.liveTalkClient) var liveTalkClient
    
    public enum Action {
        case viewDidLoad
        case fetchChatToken
        case didSuccessFetchChatToken(token: String)
        case didFailedFetchChatToken(error: Error)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewDidLoad:
                return .run { send in
                    await send(.fetchChatToken)
                }
            case .fetchChatToken:
                return .run { send in
                    do {
                        let response = try await liveTalkClient.fetchChatToken()
                        await send(.didSuccessFetchChatToken(token: response.value))
                    } catch {
                        await send(.didFailedFetchChatToken(error: error))
                    }
                }
            case .didSuccessFetchChatToken(let token):
                initChatClient(token: token)
                return .none
            case .didFailedFetchChatToken(let error):
                print(error.localizedDescription)
                return .none
            }
        }
    }
    
    private func initChatClient(token: String) {
        let config = ChatClientConfig(apiKey: .init(Secret.CHAT_API_KEY))
        ChatClient.shared = ChatClient(config: config)
        do {
            let token = try Token(rawValue: "\(token)")
            let userId = UserDefaults.standard.string(forKey: UserDefaultKeys.userId.rawValue) ?? ""
            ChatClient.shared.connectUser(userInfo: .init(id: userId), token: token)
            
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}

extension ChatClient {
    static var shared: ChatClient!
}
