//
//  LogoutViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit

class LogoutViewController: BaseViewController {
    
    var logoutView = LogoutView()

    override func viewDidLoad() {
        super.viewDidLoad()
        logoutViewActions()
    }
    
    override func loadView() {
        super.loadView()
        
        logoutView = LogoutView(frame: self.view.frame)
        self.view = logoutView
    }
    
    func logoutViewActions() {
        self.logoutView.askLogoutAlertView.cancelButtonTapCompletion = { [self] in
            self.dismiss(animated: true)
        }
    }
}
