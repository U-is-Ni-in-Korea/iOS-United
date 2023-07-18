//
//  LoginViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: BaseViewController {
    // MARK: - Property
    private var loginView = LoginView()
    private let authRepository = AuthRepository()
    private let keyChains = HeaderUtils()
    
    // MARK: - UI Property
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        loginView = LoginView(frame: self.view.frame)
        view = loginView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConfig()
        actions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAccessToken()
    }
    // MARK: - Setting
    override func setLayout() {
        super.setLayout()
    }
    override func setConfig() {
        super.setConfig()
    }
    
    // MARK: - Action Helper
    private func actions() {
        loginView.kakaoButton.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
    }
    @objc func kakaoButtonTapped() {
        hanldeKakaoLogin(completion: { kakaoToken in
            print("---------유니토큰!!!!!!!--------------")
            self.authRepository.postToken(token: kakaoToken) { data in
                print(data.accessToken, "유니토큰!!!!!!!")
                
                if let accessToken = data.accessToken {
                    self.keyChains.create(account: "accessToken", value: accessToken)
                    self.pushNicknameSettingViewController()
                }
            }
        })
    }
    
    // MARK: - Custom Method
    private func checkAccessToken() {
        let tokenExist = self.keyChains.isTokenExists(account: "accessToken")
        if tokenExist {
           pushNicknameSettingViewController()
        }
    }
    
    private func pushNicknameSettingViewController() {
        let nicknameSettingViewController = NicknameSettingViewController()
        navigationController?.pushViewController(nicknameSettingViewController, animated: false)
    }
    
    // MARK: - 카카오 로그인
    private func hanldeKakaoLogin(completion: @escaping ((String) -> Void)) {
        print("KakaoAuthVM - handleKakaoLogin() called()")
        //카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    if let oauthToken = oauthToken {
                        completion(oauthToken.accessToken)
                        print(oauthToken.accessToken)
                    }
                }
            }
        } else { //카카오톡이 설치가 안되어있으면
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        _ = oauthToken
                        if let oauthToken = oauthToken {
                            completion(oauthToken.accessToken)
                            print(oauthToken.accessToken)
                        }
                    }
                }
        }
    }
}

// MARK: - UITableView Delegate
//// MARK: - 로그아웃
//func kakaoLogOut() {
//    UserApi.shared.logout {(error) in
//        if let error = error {
//            print(error)
//        }
//        else {
//            print("logout() success.")
//        }
//    }
//}
