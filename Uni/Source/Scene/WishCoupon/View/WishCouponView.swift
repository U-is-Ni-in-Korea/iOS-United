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
    
    var wishCouponData: Int = 0 { //내소원권 컬렉션 뷰 데이터
        didSet {
            wishCouponCollectionView.wishCouponData = wishCouponData
            wishCouponCollectionView.wishCouponCollectionView.reloadData()
        }
    }
    
    // MARK: - UI Property
    
    let navigationBar = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "소원권") //백버튼 크기 변경
    
    var wishCouponCountView = WishCouponCountView()
    /**내 소원권**/
    var wishCouponCollectionView = WishCouponCollectionView()
    /**상대 소원권**/
    var wishCouponYourCollectionView = WishCouponYourCollectionView()
    
    var wishCouponEmptyView = WishCouponEmptyView()

    
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
        wishCouponCollectionView.isHidden = false
        wishCouponYourCollectionView.isHidden = true
    }
    
    private func setLayout() {
        [navigationBar, wishCouponEmptyView, wishCouponCountView,wishCouponCollectionView, wishCouponYourCollectionView].forEach {
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
        
        wishCouponEmptyView.snp.makeConstraints {
            $0.top.equalTo(wishCouponCountView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
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
}
