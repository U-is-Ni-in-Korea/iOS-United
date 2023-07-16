//
//  SettingTableViewHeaderView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

final class SettingTableViewHeaderView: UIView {
    
    private let headerTitleLabel = UILabel().then {
        $0.text = "서비스 이용"
        $0.textColor = .lightBlue600
        $0.font = SDSFont.body2.font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(7)
        }
    }
    
}
