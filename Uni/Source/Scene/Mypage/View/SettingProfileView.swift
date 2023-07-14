//
//  SettingProfileView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

class SettingProfileView: UIView {
    
    lazy var userImageView = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .gray200 //임시
    }
    
    lazy var userNameLabel = UILabel().then {
        $0.text = "김유니"
        $0.font = SDSFont.title2.font
        $0.textColor = .gray600
    }
    
    lazy var userEmailLabel = UILabel().then {
        $0.text = "uni@sparkle.com"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }
    
    lazy var editProfileButton = SDSChips(type: .blue, title: "프로필 수정")
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        self.backgroundColor = .gray000
    }
    
    private func setLayout() {
        [userImageView, userNameLabel, userEmailLabel, editProfileButton] .forEach{ addSubview($0) }
        
        userImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(23)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(76)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(34)
            $0.top.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview().inset(74)
        }
        
        userEmailLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom)
            $0.leading.equalTo(userImageView.snp.trailing).offset(34)
            $0.bottom.equalToSuperview().inset(50)
        }
        
        editProfileButton.snp.makeConstraints {
            $0.leading.equalTo(userEmailLabel.snp.trailing).offset(34)
            $0.centerY.equalToSuperview()
        }
        
    }

}
