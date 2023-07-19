//
//  CoupleConnectionMethodView.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import Foundation
import UIKit
import SDSKit
import Then

final class CoupleConnectionMethodView: UIView {

    // MARK: - UI Property
    
    let navigationBarView = SDSNavigationBar(hasBack: true, hasTitleItem: false)
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    
    let enterInvitationCodeButton = SDSButton(type: .line, state: .enabled).then {
        $0.setButtonTitle(title: "초대코드 입력하기")
    }
    
    let sendInvitationCodeButton = SDSButton(type: .fill, state: .enabled).then {
        $0.setButtonTitle(title: "초대코드 보내기")
    }
    
    private let orBackgroundView = UIView()
    
    private let orLabel = UILabel().then {
        $0.text = "or"
        $0.textColor = .lightBlue600
        $0.font = SDSFont.body2.font
    }
    
    private let separateLeftView = UIView().then {
        $0.backgroundColor = .gray200
    }
    
    
    private let separateRightView = UIView().then {
        $0.backgroundColor = .gray200
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
        self.addSubviews([enterInvitationCodeButton, sendInvitationCodeButton, orBackgroundView, logoImageView, navigationBarView])
        
        orBackgroundView.addSubviews([separateLeftView, orLabel, separateRightView])
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        enterInvitationCodeButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-66)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        orBackgroundView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.bottom.equalTo(enterInvitationCodeButton.snp.top).offset(-8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        sendInvitationCodeButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(orBackgroundView.snp.top).offset(-8)
        }
        orLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
       
        separateLeftView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.trailing.equalTo(orLabel.snp.leading).offset(-11)
            $0.height.equalTo(1)
        }
        separateRightView.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.leading.equalTo(orLabel.snp.trailing).offset(11)
            $0.height.equalTo(1)
        }
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(220)
            $0.height.equalTo(208)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(155)
        }
        
    }

}
