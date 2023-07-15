//
//  BaseViewController.swift
//  Uni
//
//  Created by 박익범 on 2023/07/05.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Layout
    func setLayout() {}

    //MARK: - Config
    func setConfig() {}
    
}
