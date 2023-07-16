//
//  DDaySettingViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/15.
//

import Foundation
import UIKit

final class DDaySettingViewController: BaseViewController {
    // MARK: - Property
    private var dDaySettingView = DDaySettingView()

    // MARK: - UI Property
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        dDaySettingView = DDaySettingView(frame: self.view.frame)
        view = dDaySettingView
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
    }

    // MARK: - Custom Method
  
}
