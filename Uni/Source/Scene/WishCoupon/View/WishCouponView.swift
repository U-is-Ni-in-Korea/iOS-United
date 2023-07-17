//
//  WishCouponView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/16.
//

import UIKit
import Then
import SDSKit
import CHTCollectionViewWaterfallLayout

final class WishCouponView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    let navigationBar = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "소원권") //백버튼 크기 변경
    
    private var wishCouponCountView = WishCouponCountView()
    /**내 소원권**/
    private var wishCouponCollectionView = WishCouponCollectionView()
    /**상대 소원권**/
    private var wishCouponYourCollectionView = WishCouponYourCollectionView()
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyle()
        setLayout()
        setupButtons()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setStyle()
        setLayout()
        setupButtons()
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        self.backgroundColor = .gray100
        wishCouponCollectionView.isHidden = false
        wishCouponYourCollectionView.isHidden = true
    }
    
    private func setLayout() {
        [navigationBar, wishCouponCountView,wishCouponCollectionView, wishCouponYourCollectionView].forEach {
            addSubview($0)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        wishCouponCountView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(128)
        }
        
        wishCouponCollectionView.snp.makeConstraints {
            $0.top.equalTo(wishCouponCountView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        wishCouponYourCollectionView.snp.makeConstraints {
            $0.top.equalTo(wishCouponCountView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Action Helper
    
    @objc func myButtonTapped() {
        switchToMyWishCouponView(showMyWishCoupon: true)
        print("switchMyButton")
        
        
    }
    
    @objc func yourButtonTapped() {
        switchToMyWishCouponView(showMyWishCoupon: false)
        print("switchYourButton")
    }
    
    private func setupButtons() {
        wishCouponCountView.myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        wishCouponCountView.yourButton.addTarget(self, action: #selector(yourButtonTapped), for: .touchUpInside)
        
    }
    
    // MARK: - Custom Method
    
    private func switchToMyWishCouponView(showMyWishCoupon: Bool) {
        if showMyWishCoupon {
            DispatchQueue.main.async {
                self.wishCouponCollectionView.isHidden = false
                self.wishCouponYourCollectionView.isHidden = true
                self.wishCouponCountView.yourButton.setTitleColor(.gray300, for: .normal)
                self.wishCouponCountView.yourButton.titleLabel?.font = SDSFont.body1Regular.font
                self.wishCouponCountView.myButton.setTitleColor(.lightBlue600, for: .normal)
                self.wishCouponCountView.myButton.titleLabel?.font = SDSFont.subTitle.font
                self.wishCouponCollectionView.scrollToInitialPosition()
            }
        }
        else {
            DispatchQueue.main.async {
                self.wishCouponCollectionView.isHidden = true
                self.wishCouponYourCollectionView.isHidden = false
                self.wishCouponCountView.myButton.setTitleColor(.gray300, for: .normal)
                self.wishCouponCountView.myButton.titleLabel?.font = SDSFont.body1Regular.font
                self.wishCouponCountView.yourButton.setTitleColor(.lightBlue600, for: .normal)
                self.wishCouponCountView.yourButton.titleLabel?.font = SDSFont.subTitle.font
                self.wishCouponYourCollectionView.scrollToInitialPosition()
            }
        }
    }
}
