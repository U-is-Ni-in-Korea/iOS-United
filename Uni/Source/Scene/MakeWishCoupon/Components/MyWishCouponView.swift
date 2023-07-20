//
//  MyWishView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/18.
//

import UIKit
import SDSKit
import Then

class MyWishCouponView: UIView {
    
    var myWishImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }

    let myWishIsLabel = UILabel().then {
        $0.text = "나의 소원은"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }
    
    public var myWishLabel = UILabel().then {
        $0.text = "유니행복앱잼"
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
        
        addSubviews([myWishImageView, myWishIsLabel, myWishLabel, dashlineStackView, expirationDateTitleLabel, expirationDateLabel])
        
        for _ in 0...24 {
            let horizontalView = UIView()
            horizontalView.backgroundColor = .gray200
            self.dashlineStackView.addArrangedSubview(horizontalView)
        }

        myWishImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height/13)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(UIScreen.main.bounds.height/6)
        }
        
        myWishIsLabel.snp.makeConstraints {
            $0.top.equalTo(myWishImageView.snp.bottom).offset(UIScreen.main.bounds.height/80)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        myWishLabel.snp.makeConstraints {
            $0.top.equalTo(myWishIsLabel.snp.bottom).offset(4)
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
