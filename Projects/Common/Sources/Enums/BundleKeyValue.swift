//
//  BundleKeyValue.swift
//  Common
//
//  Created by 김민석 on 1/17/24.
//

import Foundation

public enum BundleKeyValue: String {
    case KAKAO_NATIVE_APP_KEY
    
    private var key: String {
        return self.rawValue
    }
    
    public var stringValue: String? {
        switch self {
        case .KAKAO_NATIVE_APP_KEY:
            return Bundle.main.object(forInfoDictionaryKey: self.key) as? String
        }
    }
}
