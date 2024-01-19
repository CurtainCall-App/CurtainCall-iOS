//
//  AppDelegate.swift
//  App
//
//  Created by 김민석 on 1/19/24.
//

import UIKit

import NaverThirdPartyLogin

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
    
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(#function, url)
        NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        return true
    }
}
