//
//  AccountViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

final class AccountViewController: UIViewController {

    var accountView: AccountView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        accountView = AccountView(frame: self.view.frame)
        self.view = accountView
    }

}
