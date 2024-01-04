//
//  AppRootManager.swift
//  CurtainCall
//
//  Created by 김민석 on 1/4/24.
//

import Foundation

final class AppRootManager: ObservableObject {
    @Published var currentRoot: AppRootType = .splash
    
    enum AppRootType {
        case splash
        case onboarding
        case login
        case main
    }
    
    func changeFirstRoot() {
        if !UserDefaults.standard[.isNotFirstUser] {
            currentRoot = .onboarding
        } else if let _ = UserDefaults.standard[.accessToken] {
            currentRoot = .main
        } else {
            currentRoot = .login
        }
    }

}
