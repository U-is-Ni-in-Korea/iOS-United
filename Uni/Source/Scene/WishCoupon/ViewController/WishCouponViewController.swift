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
    private var myWishCouponData: Int = 0 {
        didSet {
            if myWishCouponData == 0 {
                wishCouponView.wishCouponCollectionView.backgroundColor = .clear
                wishCouponView.wishCouponData = myWishCouponData
            }
            else {
                wishCouponView.wishCouponCollectionView.backgroundColor = .gray100
                wishCouponView.wishCouponData = myWishCouponData
            }
        }
    }
    private var yourWishCouponData: Int = 0 {
        didSet {
            if yourWishCouponData == 0 {
                wishCouponView.wishCouponYourCollectionView.backgroundColor = .clear
                wishCouponView.wishCouponData = yourWishCouponData
            }
            else {
                wishCouponView.wishCouponYourCollectionView.backgroundColor = .gray100
                wishCouponView.wishCouponYourCollectionView.wishCouponData = yourWishCouponData // wishCouponData가 겹치지 않도록 상대소원권 컬렉션뷰에 따로 뺌
            }
        }
    }
    
    // MARK: - Property
    
    private var wishCouponView = WishCouponView()
    
    // MARK: - UI Property
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        actions()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.myWishCouponData = 8
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.yourWishCouponData = 9
        })
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
    
    private func actions() {
        wishCouponView.wishCouponCountView.myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        wishCouponView.wishCouponCountView.yourButton.addTarget(self, action: #selector(yourButtonTapped), for: .touchUpInside)
    }
    
    @objc func myButtonTapped() {
        switchToMyWishCouponView(showMyWishCoupon: true)
        print("switchMyButton")

    }
    
    @objc func yourButtonTapped() {
        switchToMyWishCouponView(showMyWishCoupon: false)
        print("switchYourButton")
    }
    
    // MARK: - Custom Method
    private func switchToMyWishCouponView(showMyWishCoupon: Bool) {
        if showMyWishCoupon {
            /// 나의 소원권
            
            DispatchQueue.main.async {
                self.wishCouponView.wishCouponEmptyView.noneLabel.text = "아직 소원권이 없어요!"
                self.wishCouponView.wishCouponCollectionView.isHidden = false
                self.wishCouponView.wishCouponYourCollectionView.isHidden = true
                self.wishCouponView.wishCouponCountView.yourButton.setTitleColor(.gray300, for: .normal)
                self.wishCouponView.wishCouponCountView.yourButton.titleLabel?.font = SDSFont.body1Regular.font
                self.wishCouponView.wishCouponCountView.myButton.setTitleColor(.lightBlue600, for: .normal)
                self.wishCouponView.wishCouponCountView.myButton.titleLabel?.font = SDSFont.subTitle.font
                self.wishCouponView.wishCouponCollectionView.scrollToInitialPosition()
            }
        }
        else {
            /// 상대 소원권
            DispatchQueue.main.async {
                self.wishCouponView.wishCouponEmptyView.noneLabel.text = "아직 상대의 소원권이 없어요!"
                self.wishCouponView.wishCouponCollectionView.isHidden = true
                self.wishCouponView.wishCouponYourCollectionView.isHidden = false
                self.wishCouponView.wishCouponCountView.myButton.setTitleColor(.gray300, for: .normal)
                self.wishCouponView.wishCouponCountView.myButton.titleLabel?.font = SDSFont.body1Regular.font
                self.wishCouponView.wishCouponCountView.yourButton.setTitleColor(.lightBlue600, for: .normal)
                self.wishCouponView.wishCouponCountView.yourButton.titleLabel?.font = SDSFont.subTitle.font
                self.wishCouponView.wishCouponYourCollectionView.scrollToInitialPosition()
            }
        }
    }
    
}

