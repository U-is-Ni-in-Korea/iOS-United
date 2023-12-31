//
//  LoginView.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import Foundation
import UIKit
import SDSKit
import Then

final class LoginView: UIView {
    
    // MARK: - UI Property
    
    let kakaoButton = UIButton().then {
        $0.backgroundColor = UIColor(hex: 0xFEE500)
        $0.setTitle("카카오 로그인", for: .normal)
        $0.setTitleColor(UIColor.gray600, for: .normal)
        $0.titleLabel?.font = SDSFont.btn2.font
        $0.layer.cornerRadius = 10
        var kakaoConfig = UIButton.Configuration.plain()
        kakaoConfig.image = SDSIcon.icKakaoLogin
        kakaoConfig.imagePadding = 8
        kakaoConfig.imagePlacement = .leading
        kakaoConfig.titleAlignment = .center
        $0.configuration = kakaoConfig
        $0.layer.applyDepth1Shadow()
    }
    let appleButton = UIButton().then {
        $0.backgroundColor = UIColor(hex: 0x232323)
        $0.setTitle("Apple 로그인", for: .normal)
        $0.setTitleColor(UIColor.gray000, for: .normal)
        $0.titleLabel?.font = SDSFont.btn2.font
        $0.layer.cornerRadius = 10
        var appleConfig = UIButton.Configuration.plain()
        appleConfig.image = SDSIcon.icAppleLogin
        appleConfig.imagePadding = 8
        appleConfig.imagePlacement = .leading
        appleConfig.titleAlignment = .center
        $0.configuration = appleConfig
        $0.layer.applyDepth1Shadow()
    }
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setLayout()
        self.setConfig()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setLayout()
        self.setConfig()
    }
    
    private func setConfig() {
        self.backgroundColor = UIColor.gray000
    }
    
    private func setLayout() {
        self.addSubviews([kakaoButton, appleButton, logoImageView])
        
        kakaoButton.snp.makeConstraints {
            $0.bottom.equalTo(appleButton.snp.top).offset(-16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        appleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(155)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        logoImageView.snp.makeConstraints {
            $0.height.equalTo(208)
            $0.width.equalTo(220)
            $0.bottom.equalTo(kakaoButton.snp.top).offset(-139.adjustedH)
            $0.centerX.equalToSuperview()
        }
    }
    
}
