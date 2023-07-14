//
//  HomeViewController.swift
//  Uni
//
//  Created by 박익범 on 2023/07/05.
//

import UIKit

final class HomeViewController: BaseViewController {
    let homeView = HomeView()
    private let homeRepository = HomeRepository()

    //MARK: - life cycle
    override func loadView() {
        super.loadView()
        self.view = homeView
        
        homeView.bindData(myScore: 15,
                          partnerScore: 10,
                          drawScore: 2,
                          dDay: 100)
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
    
    
    //MARK: - DataBinding
    
}
