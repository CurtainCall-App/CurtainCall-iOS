//
//  GenreType.swift
//  Common
//
//  Created by 김민석 on 3/17/24.
//

import Foundation

public enum Genre: String, Decodable ,Hashable {
    case play = "PLAY"
    case musical = "MUSICAL"
    
    public var nameKR: String {
        switch self {
        case .play: "연극"
        case .musical: "뮤지컬"
        }
    }
}
