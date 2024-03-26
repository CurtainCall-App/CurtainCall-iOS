//
//  CreateReviewBody.swift
//  Review
//
//  Created by 김민석 on 3/17/24.
//

import Foundation

struct CreateReviewBody: Encodable {
    let showId: String
    let grade: Int
    let content: String
}
