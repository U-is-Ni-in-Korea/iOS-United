//
//  WishCouponEmptyView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/18.
//

import UIKit
import Then
import SDSKit

final class WishCouponEmptyView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    let noneLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .gray400
        $0.font = SDSFont.body1.font
    }
    
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
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.addSubview(noneLabel)
        
        noneLabel.snp.makeConstraints {
            $0.top.equalTo(200.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
}
