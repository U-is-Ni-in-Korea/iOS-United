//
//  YourWishCouponView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/19.
//

import UIKit
import SDSKit
import Then

class YourWishCouponView: UIView {

    
    var yourWishImageView = UIImageView().then {
        $0.backgroundColor = .gray200 // 이미지
    }

    let yourWishIsLabel = UILabel().then {
        $0.text = "상대 소원은"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }
    
    var yourWishLabel = UILabel().then {
        $0.text = "데모데이행복하자"
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
        $0.textAlignment = .center
    }
    
    let dashlineStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
        $0.backgroundColor = .clear
    }
    
    let expirationDateTitleLabel = UILabel().then {
        $0.text = "유효기간"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }
    
    let expirationDateLabel = UILabel().then {
        $0.text = "우리가 사랑할때까지"
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        self.layer.applyDepthAndDepth3_1Shadow()
        self.applyDepth3_2Shadow()
        
        addSubviews([yourWishImageView, yourWishIsLabel, yourWishLabel, dashlineStackView, expirationDateTitleLabel, expirationDateLabel])
        
        for _ in 0...24 {
            let horizontalView = UIView()
            horizontalView.backgroundColor = .gray200
            self.dashlineStackView.addArrangedSubview(horizontalView)
        }

        yourWishImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height/13)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(UIScreen.main.bounds.height/6)
        }
        
        yourWishIsLabel.snp.makeConstraints {
            $0.top.equalTo(yourWishImageView.snp.bottom).offset(UIScreen.main.bounds.height/80)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        yourWishLabel.snp.makeConstraints {
            $0.top.equalTo(yourWishIsLabel.snp.bottom).offset(4)
            $0.height.equalTo(72)
            $0.width.equalTo(252)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        dashlineStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        expirationDateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dashlineStackView.snp.bottom).offset(UIScreen.main.bounds.height/20)
            $0.centerX.equalToSuperview()
        }
        expirationDateLabel.snp.makeConstraints {
            $0.top.equalTo(expirationDateTitleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/20)
        }
    }
}
