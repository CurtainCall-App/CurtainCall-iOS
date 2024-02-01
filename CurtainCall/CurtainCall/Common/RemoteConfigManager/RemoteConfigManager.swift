//
//  RemoteConfigManager.swift
//  CurtainCall
//
//  Created by 김민석 on 2/1/24.
//

import Foundation

import FirebaseRemoteConfig

final class RemoteConfigManager {
    static let shared = RemoteConfigManager()
    
    private init() { 
        initRemoteConfig()
    }
    private static let remoteConfig = RemoteConfig.remoteConfig()
    
    
    private func initRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        Self.remoteConfig.configSettings = settings
        
        Self.remoteConfig.fetch { status, error in
            if status == .success {
                Self.remoteConfig.activate { changed, error in
                    guard let error else { return }
                }
            }
        }
    }
    
    func stringValue(_ key: RemoteConfigKeys) -> String? {
        return Self.remoteConfig.configValue(forKey: key.rawValue).stringValue
    }
}

enum RemoteConfigKeys: String {
    case ios_minimum_version
}
