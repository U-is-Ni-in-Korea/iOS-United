//
//  SplashViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/21.
//

import Foundation
import UIKit

class SplashViewController: BaseViewController {
    // MARK: - Property
    let keyChains = HeaderUtils()
    
    // MARK: - UI Property
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        self.view.backgroundColor = .gray000
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
            self.setRootViewController()
        })
    }
    // MARK: - Setting
    override func setLayout() {
        super.setLayout()
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(208)
            $0.width.equalTo(220)
        }
    }
    override func setConfig() {
        super.setConfig()
    }
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    private func setRootViewController() {
        let key = keyChains.read(account: "accessToken")
        print(key)
        let userDefaultsManager = UserDefaultsManager.shared
        if userDefaultsManager.hasOnboarded {
  
            if keyChains.isTokenExists(account: "accessToken") {
                ///로그인 + 토큰 존재
                if userDefaultsManager.hasCoupleCode {
                    let homeViewController = HomeViewController()
                    changeRootViewController(UINavigationController(rootViewController: homeViewController))
                }
                else {
                    let loginViewController = LoginViewController()
                    changeRootViewController(UINavigationController(rootViewController: loginViewController))
                }
                
            }
            else {
                let loginViewController = LoginViewController()
                changeRootViewController(UINavigationController(rootViewController: loginViewController))
            }
        }
        ///온보딩이 처음일 때
        else {
            let onboardingViewController = OnboardingViewController()
            changeRootViewController(onboardingViewController)
        }
    }
}
extension SplashViewController {
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
}
