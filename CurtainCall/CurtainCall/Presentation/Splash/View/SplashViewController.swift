//
//  SplashViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/03.
//

import UIKit

import SnapKit
import SwiftKeychainWrapper
import FirebaseRemoteConfig

final class SplashViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.splashLogo)
        imageView.alpha = 0
        return imageView
    }()
    
    // MARK: - Properties
    
    private let remoteConfigManager = RemoteConfigManager.shared
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startAnimation()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .pointColor1
        configureSubviews()
        configureConstraint()
    }
    
    private func configureSubviews() {
        view.addSubview(logoImageView)
    }
    
    private func configureConstraint() {
        logoImageView.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseOut, animations: {
            self.logoImageView.alpha = 1
        }, completion: { [weak self] _ in
            guard let self else { return }
            if self.isNeedUpdate() {
                self.presentUpdateAlert()
            } else if !UserDefaults.standard[.isNotFirstUser] {
                pushToOnboardingViewController()
                UserDefaults.standard[.isNotFirstUser] = true
            } else if let accessToken = UserDefaults.standard[.accessToken] {
                UserDefaults.standard[.isNotGuestUser] = true
                self.changeRootViewController(TempMainTabBarController())
            } else {
                let loginViewController = LoginViewController(
                    viewModel: LoginViewModel()
                )
                self.changeRootViewController(UINavigationController(rootViewController: loginViewController))
            }
        })
    }
    
    private func pushToOnboardingViewController() {
        let onboardingViewModel = OnboardingViewModel()
        self.changeRootViewController(OnboardingViewController(
            viewModel: onboardingViewModel
        ))
    }
    
    private func presentUpdateAlert() {
        let alert = UIAlertController(title: "버전 업데이트", message: "커튼콜 최신버전으로 업데이트 해주세요.", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "업데이트", style: .default) { _ in
            self.openAppStore()
        }
        alert.addAction(updateAction)
        self.present(alert, animated: true)
    }
    
    private func openAppStore() {
        let url = URL(string: "https://apps.apple.com/kr/app/%EC%BB%A4%ED%8A%BC%EC%BD%9C/id6450673014")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func isNeedUpdate() -> Bool {
        guard let minimumAppVersion = remoteConfigManager.stringValue(.ios_minimum_version),
              let currentAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return false
        }
              
        let minimumAppVersionSplit = minimumAppVersion.split(separator: ".").compactMap { Int($0) }
        let currentAppVersionSplit = currentAppVersion.split(separator: ".").compactMap { Int($0) }
        
        if minimumAppVersionSplit[0] > currentAppVersionSplit[0] {
            return true
        } else if minimumAppVersionSplit[1] > currentAppVersionSplit[1] {
            return true
        } else if minimumAppVersionSplit[2] > currentAppVersionSplit[2] {
            return true
        }
        return false
        
    }
}
