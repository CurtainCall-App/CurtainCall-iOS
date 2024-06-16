//
//  DeleteAccountBody.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import Foundation

public struct DeleteAccountBody: Encodable, Equatable {
    public let reason: String
    public let content: String
    
    public init(reason: String, content: String) {
        self.reason = reason
        self.content = content
    }
}
