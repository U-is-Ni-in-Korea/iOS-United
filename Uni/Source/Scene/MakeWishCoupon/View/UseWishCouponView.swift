//
//  UseWishCouponAlertView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/19.
//

import UIKit
import SDSKit
import Then

class UseWishCouponView: UIView {

    let askUseWishCouponAlertView = AlertView(title: "소원권을 사용하시나요?", message: "사용하신 소원권은 돌아오지 않아요", cancelButtonMessage: "취소", okButtonMessage: "확인", type: .alert)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubview(askUseWishCouponAlertView)
        
        askUseWishCouponAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
