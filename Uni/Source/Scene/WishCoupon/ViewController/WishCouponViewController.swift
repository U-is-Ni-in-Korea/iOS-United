//
//  WishCouponViewController.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/16.
//

import UIKit
import Then
import SDSKit
import CHTCollectionViewWaterfallLayout

class WishCouponViewController: BaseViewController {
    
    // MARK: - Property
    
    private var wishCouponView = WishCouponView()
    
    // MARK: - UI Property
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
    }
    
    override func loadView() {
        super.loadView()
        
        wishCouponView = WishCouponView(frame: self.view.frame)
        self.view = wishCouponView
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        
    }
    
    override func setLayout() {
        
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}

