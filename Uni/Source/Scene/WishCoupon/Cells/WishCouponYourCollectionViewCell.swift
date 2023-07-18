//
//  WishCouponYourCollectionViewCell.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/17.
//

import UIKit
import UIKit
import Then
import SDSKit

final class WishCouponYourCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI Property
    
    private let wishCouponView = SDSCardWish(title: "집 데려다주기", type: .title)
    
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
        wishCouponView.layer.applyDepth2_1Shadow()
        wishCouponView.layer.applyDepth2_2Shadow()
    }
    
    private func setLayout() {
        [wishCouponView].forEach {
            self.contentView.addSubview($0)
        }
        
        wishCouponView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    

}
