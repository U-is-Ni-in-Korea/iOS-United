//
//  WishCouponCountView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/16.
//

import UIKit
import Then
import SDSKit

final class WishCouponCountView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    private let messageLabel = UILabel().then {
        $0.text = "남은 소원권을 사용해보세요!"
        $0.textColor = .gray600
        $0.font = SDSFont.subTitle.font
    }
    
    private let countLabel = UILabel().then {
        $0.text = "사용 가능한 소원권이 6개 있어요" // 서버에서 받아오는 값 생각하기
        $0.textColor = .gray350
        $0.font = SDSFont.body2.font
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

    }
    
    private func setLayout() {
        [messageLabel, countLabel].forEach {
            addSubview($0)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}
