//
//  LoginViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

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
        UserDefaultsManager.shared.save(value: false, forkey: .isAlreadyFinish)
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
        loginView.appleButton.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
    }
    @objc func kakaoButtonTapped() {
        loginView.kakaoButton.isEnabled = false
        loginView.appleButton.isEnabled = false
        hanldeKakaoLogin(completion: { kakaoToken in
            self.authRepository.postToken(socialType: "kakao", token: kakaoToken) { data in
                self.loginView.kakaoButton.isEnabled = true
                self.loginView.appleButton.isEnabled = true
                if let accessToken = data.accessToken {
                    self.keyChains.create(account: "accessToken", value: accessToken)
                    self.hasCouple(loginCase: "카카오")
                }
            }
        })
    }
    
    @objc func appleButtonTapped() {
        loginView.kakaoButton.isEnabled = false
        loginView.appleButton.isEnabled = false
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
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
        //카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    self.loginView.kakaoButton.isEnabled = true
                    self.loginView.appleButton.isEnabled = true
                }
                else {
                    if let oauthToken = oauthToken {
                        completion(oauthToken.accessToken)
                    }
                }
            }
        } else { //카카오톡이 설치가 안되어있으면
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                        self.loginView.kakaoButton.isEnabled = true
                        self.loginView.appleButton.isEnabled = true
                    }
                    else {
                        _ = oauthToken
                        if let oauthToken = oauthToken {
                            completion(oauthToken.accessToken)
                        }
                    }
                }
        }
    }
    private func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    func hasCouple(loginCase : String) {
        if UserDefaultsManager.shared.hasCoupleCode {
            let homeViewController = HomeViewController()
            self.changeRootViewController(UINavigationController(rootViewController: homeViewController))
        }
        else {
            let nicknameSettingViewController = NicknameSettingViewController()
            nicknameSettingViewController.loginCase = loginCase
            navigationController?.pushViewController(nicknameSettingViewController, animated: false)
        }
    }
}
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let identityToken = appleIDCredential.identityToken
            if let identityToken = identityToken {
                guard let appleToken = String(data: identityToken, encoding: .utf8) else { return }
                self.authRepository.postToken(socialType: "apple", token: appleToken) { data in
                    self.loginView.kakaoButton.isEnabled = true
                    self.loginView.appleButton.isEnabled = true
                    
                    if let accessToken = data.accessToken {
                        self.keyChains.create(account: "accessToken", value: accessToken)
                        self.hasCouple(loginCase: "Apple")
                    }
                }
            }
            
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.loginView.kakaoButton.isEnabled = true
        self.loginView.appleButton.isEnabled = true
    }
}
