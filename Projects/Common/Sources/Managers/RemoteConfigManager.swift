//
//  RemoteConfigManager.swift
//  Common
//
//  Created by 김민석 on 6/28/24.
//

import Foundation
import SwiftUI
import FirebaseRemoteConfig

public enum RemoteConfigKeys: String {
    case serverUrl
    case ios_minimum_version
}

public class RemoteConfigManager: ObservableObject {
    public static let shared = RemoteConfigManager()
    public static var remoteConfig: RemoteConfig?
    
    private init() { }
    
    public static func fetchConfig() {
        #if DEBUG
        let expirationDuration = 0
        #else
        let expirationDuration = 3600
        #endif
        
        remoteConfig?.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { (status, error) in
            guard error == nil, status == .success else {return}
            self.remoteConfig?.activate { (_, error) in
                guard error == nil else { return }
                Secret.BASE_URL = self.remoteConfig?.configValue(forKey: "serverUrl").stringValue ?? "http://curtaincall.ap-northeast-2.elasticbeanstalk.com:8080"
            }
        }
    }
    
    public static func getBool(from key: RemoteConfigKeys) -> Bool {
        return remoteConfig?.configValue(forKey: key.rawValue).boolValue ?? true
    }
    
    public static func getString(from key: RemoteConfigKeys) -> String? {
        return remoteConfig?.configValue(forKey: key.rawValue).stringValue ?? ""
    }
    
    public static func getNumber(from key: RemoteConfigKeys) -> NSNumber {
        return remoteConfig?.configValue(forKey: key.rawValue).numberValue ?? 0
    }
    
    public static func getJson(from key: RemoteConfigKeys) -> [String: Any] {
        return remoteConfig?.configValue(forKey: key.rawValue).jsonValue as? [String: Any] ?? [:]
    }

}
