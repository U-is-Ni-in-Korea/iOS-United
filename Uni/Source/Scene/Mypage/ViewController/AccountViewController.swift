//
//  AccountViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

class AccountViewController: UIViewController, AccountViewDelegate {
    
    var accountView = AccountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountActions()
    }
    
    override func loadView() {
        super.loadView()
        
        accountView = AccountView(frame: self.view.frame)
        accountView.delegate = self
        self.view = accountView
    }
    
    func accountActions() {
        self.accountView.accountViewNavi.backButtonCompletionHandler = { [self] in self.navigationController?.popViewController(animated: true)
        }
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0 : let logoutViewController = LogoutViewController()
            logoutViewController.modalPresentationStyle = .overFullScreen
            logoutViewController.modalTransitionStyle = .crossDissolve
            self.present(logoutViewController, animated: true, completion: nil)

        case 1 : let withdrawViewController = WithdrawViewController()
            withdrawViewController.modalPresentationStyle = .overFullScreen
            withdrawViewController.modalTransitionStyle = .crossDissolve
            self.present(withdrawViewController, animated: true, completion: nil)
            
        case 2 : let disconnectViewController = DisconnectViewController()
            disconnectViewController.modalPresentationStyle = .overFullScreen
            disconnectViewController.modalTransitionStyle = .crossDissolve
            self.present(disconnectViewController, animated: true, completion: nil)

        default:
            return
        }
    }
}
