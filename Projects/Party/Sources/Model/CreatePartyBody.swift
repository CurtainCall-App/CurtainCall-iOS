//
//  CreatePartyBody.swift
//  Party
//
//  Created by 김민석 on 4/27/24.
//

import Foundation

public struct CreatePartyBody: Encodable {
    public init(showId: String, showAt: String, title: String, content: String, maxMemberNum: Int) {
        self.showId = showId
        self.showAt = showAt
        self.title = title
        self.content = content
        self.maxMemberNum = maxMemberNum
    }
    let showId: String
    let showAt: String
    let title: String
    let content: String
    let maxMemberNum: Int
}
