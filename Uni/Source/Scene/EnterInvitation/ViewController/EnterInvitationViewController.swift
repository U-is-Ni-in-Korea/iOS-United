//
//  EnterInvitationViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/15.
//

import Foundation
import UIKit

final class EnterInvitationViewController: BaseViewController {
    // MARK: - Property
    private var enterInvitationView = EnterInvitationView()

    // MARK: - UI Property
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        enterInvitationView = EnterInvitationView(frame: self.view.frame)
        view = enterInvitationView
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
