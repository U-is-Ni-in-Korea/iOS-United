//
//  NicknameSettingViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import Foundation
import UIKit
import SwiftUI

final class NicknameSettingViewController: BaseViewController {
    // MARK: - Property
    var loginCase: String = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    // MARK: - Setting
    override func setLayout() {
        self.view.backgroundColor = .white
        let inputNickNameView = UIHostingController(rootView: NickNameInputView(viewModel: NickNameInputViewModel(navigationController: self.navigationController!)))
        self.view.addSubview(inputNickNameView.view)
        
        inputNickNameView.view.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
}
  
   
