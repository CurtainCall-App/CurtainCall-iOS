//
//  ShowType.swift
//  Common
//
//  Created by 김민석 on 12/8/24.
//

import Foundation

public enum ShowType {
    case theater
    case musical
    
    public var title: String {
        switch self {
        case .theater: return "연극"
        case .musical: return "뮤지컬"
        }
    }
    public var APIName: String {
        switch self {
        case .theater: return "PLAY"
        case .musical: return "MUSICAL"
        }
    }
}
