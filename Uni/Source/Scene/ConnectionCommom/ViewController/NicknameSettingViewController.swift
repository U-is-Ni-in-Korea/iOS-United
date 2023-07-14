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
    }
    // MARK: - Setting
    override func setLayout() {
        super.setLayout()
    }
    override func setConfig() {
        super.setConfig()
    }

    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}

// MARK: - UITableView Delegate