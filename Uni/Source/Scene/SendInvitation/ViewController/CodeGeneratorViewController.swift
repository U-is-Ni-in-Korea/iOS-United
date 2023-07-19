//
//  CodeGeneratorViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/15.
//

import Foundation
import UIKit

final class CodeGeneratorViewController: BaseViewController {
    // MARK: - Property
    var inviteCode: String = ""
    private var codeGeneratorView = CodeGeneratorView()

    // MARK: - UI Property
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        codeGeneratorView = CodeGeneratorView(frame: self.view.frame)
        view = codeGeneratorView
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
        codeGeneratorView.codeLabel.text = inviteCode 
    }

    // MARK: - Action Helper
    private func actions() {
    }

    // MARK: - Custom Method
  
}
