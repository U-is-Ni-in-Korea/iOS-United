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
    }
    
    override func loadView() {
        super.loadView()
        
        accountView = AccountView(frame: self.view.frame)
        accountView.delegate = self
        self.view = accountView
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        
        print("alert 만들기")

    }

}
