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
    
    private let wishCouponListView = SDSCardWishView()
    
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
        wishCouponListView.layer.applyDepth2_1Shadow()
        wishCouponListView.layer.applyDepth2_2Shadow()
    }
    
    private func setLayout() {
        [wishCouponListView].forEach {
            self.contentView.addSubview($0)
        }
        
        wishCouponListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
    func configureYourCell(yourWishCouponData: WishCouponList?) {
        print("상대소원권 보여죠")
        if let url = URL(string: yourWishCouponData?.image ?? "") {
            wishCouponListView.wishImageView.kf.setImage(with: url)
        }
        wishCouponListView.setType(title: yourWishCouponData?.content ?? "", type: .title)
        if let isUsed = yourWishCouponData?.isUsed {
            wishCouponListView.chipLabel.text = usedCheck(value: isUsed).0
            wishCouponListView.chipView.backgroundColor = usedCheck(value: isUsed).1
            wishCouponListView.chipLabel.textColor = usedCheck(value: isUsed).2
        }
    }
    
    func usedCheck(value: Bool) -> (String, UIColor, UIColor) {
        return value ? ("소원 성취", UIColor.gray100, UIColor.gray400) : ("소원권 사용하기", UIColor.green50, UIColor.green600)
    }
}
