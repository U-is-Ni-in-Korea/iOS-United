//
//  LoginViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import UIKit

class LoginViewController: BaseViewController {
    // MARK: - Property
    private var loginView = LoginView()
    private lazy var kakaoAuthViewModel = KakaoAuthViewModel()
    
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
    
    // MARK: - Custom Method
    @objc func kakaoButtonTapped() {
        kakaoAuthViewModel.hanldeKakaoLogin()
    }
}

// MARK: - UITableView Delegate
