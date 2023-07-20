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
import Kingfisher

final class WishCouponCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI Property
    
    let newWishCouponView = SDSCardWishView()
    lazy var wishCouponListView = SDSCardWishView()
    
    let chipView = UIView().then {
        $0.layer.cornerRadius = 13
        $0.backgroundColor = .lightBlue50
    }
    
    let chipLabel = UILabel().then {
        $0.font = SDSFont.caption.font
        $0.textColor = .lightBlue600
    }
    
    let newWishImageView = UIImageView().then {
        $0.image = UIImage(named: "newWish")
    }
    
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
        wishCouponListView.layer.applyDepth2_1Shadow()
        wishCouponListView.layer.applyDepth2_2Shadow()
        
    }
    
    private func setLayout() {
        [newWishCouponView, wishCouponListView].forEach {
            self.contentView.addSubview($0)
        }
        newWishCouponView.addSubviews([newWishImageView, chipView])
        chipView.addSubview(chipLabel)
        
        newWishCouponView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        wishCouponListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        newWishImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40.adjustedH)
        }
        
        chipView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(26)
        }
        chipLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
    
    func configure(with type: SDSCardWishType) {
        if type == .noTitle {
            newWishCouponView.isHidden = false
            wishCouponListView.isHidden = true
        } else {
            newWishCouponView.isHidden = true
            wishCouponListView.isHidden = false
        }
    }
    
    //내소원권 컬렉션뷰셀에 내용을 붙여주는
    func configureMyNewCell(myWishCouponData: WishCouponDataModel?) {
        print("새소원권 개수 칩스입니당")
        chipLabel.text = "새 소원권 \(myWishCouponData?.newWishCoupon ?? 0)개"
    }
    
    func configureMyCell(myWishCouponData: WishCouponList?) {
        print("내소원권 보여죠")
        if let url = URL(string: myWishCouponData?.image ?? "") {
            wishCouponListView.wishImageView.kf.setImage(with: url)
        }
        wishCouponListView.setType(title: myWishCouponData?.content ?? "", type: .title)
        if let isUsed = myWishCouponData?.isUsed {
            wishCouponListView.chipLabel.text = usedCheck(value: isUsed).0
            wishCouponListView.chipView.backgroundColor = usedCheck(value: isUsed).1
            wishCouponListView.chipLabel.textColor = usedCheck(value: isUsed).2
        }
    }
    
    func usedCheck(value: Bool) -> (String, UIColor, UIColor) {
        return value ? ("소원 성취",UIColor.gray100, UIColor.gray400): ("소원권 사용하기", UIColor.green50, UIColor.green600)
    }
}
