//
//  LogoutViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit

class LogoutViewController: UIViewController {
    
    var logoutView = LogoutView()

    override func viewDidLoad() {
        super.viewDidLoad()
        logoutActions()
    }
    
    override func loadView() {
        super.loadView()
        
        logoutView = LogoutView(frame: self.view.frame)
        self.view = logoutView
    }
    
    func logoutActions() {
        self.logoutView.askLogoutAlertView.cancelButtonTapCompletion = { [self] in
            self.dismiss(animated: true)
        }
    }
}
