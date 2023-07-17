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
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setStyle()
        setLayout()
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        self.backgroundColor = .gray100
    }
    
    private func setLayout() {
        [navigationBar, wishCouponCountView, wishCouponYourCollectionView].forEach {
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
        
//        wishCouponCollectionView.snp.makeConstraints {
//            $0.top.equalTo(wishCouponCountView.snp.bottom)
//        }
        
        wishCouponYourCollectionView.snp.makeConstraints {
            $0.top.equalTo(wishCouponCountView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}
