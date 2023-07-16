//
//  SettingTableViewCell.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

final class SettingTableViewCell: UITableViewCell {
    
    private let settingImageView = UIImageView().then {
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray200 //테스트
    }
    
    private let settingTitleLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textColor = .gray600
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubviews([settingImageView, settingTitleLabel])
        
        settingImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19)
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
        }
        
        settingTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(settingImageView.snp.trailing).offset(13)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureCell(_ settingTitle: SettingTitle) {
        settingTitleLabel.text = settingTitle.title
    }
}

