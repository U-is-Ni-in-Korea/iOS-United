//
//  WishCouponCollectionViewCell.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/17.
//

import UIKit
import Then
import SDSKit
import CHTCollectionViewWaterfallLayout

final class WishCouponCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI Property
    
    let newWishCouponView = SDSCardWish(title: "d", type: .noTitle)
    let wishCouponView = SDSCardWish(title: "맥북 사주기", type: .title)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        newWishCouponView.layer.applyDepth2_1Shadow()
        newWishCouponView.layer.applyDepth2_2Shadow()
        wishCouponView.layer.applyDepth2_1Shadow()
        wishCouponView.layer.applyDepth2_2Shadow()
    }
    
    private func setLayout() {
        [newWishCouponView, wishCouponView].forEach {
            self.contentView.addSubview($0)
        }
        
        newWishCouponView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        wishCouponView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
    func configure(with type: SDSCardWishType) {
        if type == .noTitle {
            newWishCouponView.isHidden = false
            wishCouponView.isHidden = true
        } else {
            newWishCouponView.isHidden = true
            wishCouponView.isHidden = false
        }
    }
    

    
}
