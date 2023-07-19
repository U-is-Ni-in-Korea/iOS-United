//
//  CompletedWishCouponViewController.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/19.
//

import UIKit

class CompletedWishCouponViewController: BaseViewController {

    // MARK: - Property
    
    private var completedWishCouponView = CompletedWishCouponView()
    
    // MARK: - UI Property
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
//        completedWishCouponView.makeWishButton.setButtonTitle(title: "소원권 사용하기")
    }
    
    override func loadView() {
        super.loadView()
        
        completedWishCouponView = CompletedWishCouponView(frame: self.view.frame)
        self.view = completedWishCouponView
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        
    }
    
    override func setLayout() {
        
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    


}
