//
//  NicknameSettingView.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import Foundation
import UIKit
import SDSKit
import Then

final class NicknameSettingView: UIView {

    // MARK: - UI Property
    
    let navigationBarView = SDSNavigationBar(hasBack: true, hasTitleItem: false)
    
    let nextButton = SDSButton(type: .fill, state: .disabled).then {
        $0.setButtonTitle(title: "다음")
    }
    
    private let nicknameBackgroundView = UIView()
    
    private let nicknameSetTitleLabel = UILabel().then {
        $0.text = "사용할 닉네임을 입력하세요"
        $0.textColor = UIColor.gray600
        $0.font = SDSFont.subTitle.font
    }
    
    private let nicknameSetSubTitleLabel = UILabel().then {
        $0.text = "내 애인이 나를 부르는 애칭은 무엇인가요?"
        $0.textColor = UIColor.gray350
        $0.font = SDSFont.body2.font
    }
    
    let nickNameTextField = SDSTextfield(placeholder: "닉네임",
                                                 errorMessage: "글자수를 초과했어요",
                                                 letterLimit: 15)



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

        nextButton.layer.applyDepth1Shadow()
        nextButton.isEnabled = false
        nickNameTextField.layer.borderColor = UIColor.gray300.cgColor
        nickNameTextField.textfieldCountLabel.text = "0/10"
        
    }

    private func setLayout() {
        self.addSubviews([navigationBarView, nextButton, nicknameBackgroundView, nickNameTextField])
        
        nicknameBackgroundView.addSubviews([nicknameSetTitleLabel, nicknameSetSubTitleLabel])
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52.adjusted)
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
        nicknameBackgroundView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(58)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        nicknameSetTitleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.leading.equalToSuperview()
        }
        nicknameSetSubTitleLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameBackgroundView.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
    }

}
