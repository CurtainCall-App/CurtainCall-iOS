//
//  SplashViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/03.
//

import UIKit

import SnapKit
import SwiftKeychainWrapper

final class SplashViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.splashLogo)
        imageView.alpha = 0
        return imageView
    }()
    
    // MARK: - Properties
    
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
            if !UserDefaults.standard[.isNotFirstUser] {
                self?.pushToOnboardingViewController()
                UserDefaults.standard[.isNotFirstUser] = true
            } else if let accessToken = UserDefaults.standard[.accessToken] {
                UserDefaults.standard[.isNotGuestUser] = true
                self?.changeRootViewController(TempMainTabBarController())
            } else {
                let loginViewController = LoginViewController(
                    viewModel: LoginViewModel()
                )
                self?.changeRootViewController(UINavigationController(rootViewController: loginViewController))
            }
        })
    }
    
    private func pushToOnboardingViewController() {
        let onboardingViewModel = OnboardingViewModel()
        self.changeRootViewController(OnboardingViewController(
            viewModel: onboardingViewModel
        ))
    }
    
    
    
}
