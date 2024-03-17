//
//  ReviewWriteViewComponents.swift
//  Review
//
//  Created by 김민석 on 3/17/24.
//

import Foundation

import Common

public struct ReviewWriteViewComponents: Equatable {
    public init(
        showId: String,
        showImage: String, 
        showName: String,
        genre: Genre
    ) {
        self.showId = showId
        self.showImage = showImage
        self.showName = showName
        self.genre = genre
    }
    
    let showId: String
    let showImage: String
    let showName: String
    let genre: Genre

}
