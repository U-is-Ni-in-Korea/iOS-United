//
//  NicknameSettingViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import Foundation
import UIKit

final class NicknameSettingViewController: BaseViewController {
    // MARK: - Property
    private var nicknameSettingView = NicknameSettingView()
    private let keyChains = HeaderUtils()

    // MARK: - UI Property
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        nicknameSettingView = NicknameSettingView(frame: self.view.frame)
        view = nicknameSettingView
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
        nicknameSettingView.navigationBarView.backButtonCompletionHandler = {
//            self.keyChains.read(account: "accessToken") = {
//                print("성공")
//            }
            let isTokenExists = self.keyChains.isTokenExists(account: "accessToken")
            if isTokenExists {
                print("존재")
                self.keyChains.delete("accessToken")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Custom Method
    
}

// MARK: - UITableView Delegate
