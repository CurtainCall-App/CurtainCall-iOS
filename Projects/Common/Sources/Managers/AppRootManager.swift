//
//  Source.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/12/24.
//

import Foundation

public final class AppRootManager: ObservableObject {
    @Published public var currentRoot: AppRootType = .splash
    
    public init() { }
    
    public enum AppRootType: String {
        case splash
        case onboarding
        case login
        case main
    }
    
    public func changeFirstView() {
        if let _ = UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue) {
            currentRoot = .main
        } else {
            currentRoot = .login
        }
    }
}
