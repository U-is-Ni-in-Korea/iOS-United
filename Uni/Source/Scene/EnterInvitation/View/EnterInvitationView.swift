//
//  EnterInvitationView.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/15.
//

import Foundation
import UIKit
import SDSKit
import Then

final class EnterInvitationView: UIView {

    // MARK: - UI Property
    
    let navigationBarView = SDSNavigationBar(hasBack: true, hasTitleItem: false)

    private let enterInvitationTitleLabel = UILabel().then {
        $0.text = "초대코드를 입력해주세요"
        $0.font = SDSFont.subTitle.font
        $0.textColor = UIColor.gray600
    }

    let invitationTextField = SDSTextfield(placeholder: "ag14f0hkl", errorMessage: "입력하신 코드 정보를 찾을 수 없어요", letterLimit: 11).then {
        $0.textfieldCountLabel.isHidden = true
    }
    
    let connectionButton = SDSButton(type: .fill, state: .disabled).then {
        $0.setButtonTitle(title: "연결하기")
        $0.isEnabled = false
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
        invitationTextField.sdsTextfield.keyboardType = .namePhonePad

    }

    private func setLayout() {
        self.addSubviews([navigationBarView, enterInvitationTitleLabel, invitationTextField, connectionButton])

        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        enterInvitationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(70)
            $0.leading.equalToSuperview().inset(20)
        }
        
        invitationTextField.snp.makeConstraints {
            $0.top.equalTo(enterInvitationTitleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        connectionButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
        
        
    }

}
