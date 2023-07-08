//
//  HomeViewController.swift
//  Uni
//
//  Created by 박익범 on 2023/07/05.
//

import UIKit

final class HomeViewController: BaseViewController {
    let homeView = HomeView()

    //MARK: - life cycle
    override func loadView() {
        super.loadView()
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - set view config
    override func setConfig() {
        super.setConfig()
    }
    
    override func setLayout() {
        super.setLayout()
    }
    
    //MARK: - controll function
    
}
