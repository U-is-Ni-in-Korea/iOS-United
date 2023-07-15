//
//  CodeGeneratorView.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/15.
//

import Foundation
import UIKit
import SDSKit
import Then

final class CodeGeneratorView: UIView {

    // MARK: - UI Property
    
    let navigationBarView = SDSNavigationBar(hasBack: true, hasTitleItem: false)
    
    private let logoImageView = UIImageView().then {
        $0.backgroundColor = .red
    }
    
    let nextButton = SDSButton(type: .fill, state: .enabled).then {
        $0.setButtonTitle(title: "다음")
    }
    
    let myCodeLabel = SDSChips(type: .blue, title: "나의 코드")
    
    private let codeLabel = UILabel().then {
        $0.text = "123 456 789"
        $0.textColor = .lightBlue950
        $0.font = SDSFont.subTitle.font
    }
    
    let codeCodyButton = SDSButton(type: .fill, state: .enabled).then {
        $0.setButtonTitle(title: "초대코드 복사하기")
    }
    
    let connectionCheckButton = SDSButton(type: .line, state: .enabled).then {
        $0.setButtonTitle(title: "연결 확인하기")
        $0.setImage(SDSIcon.icReset.withTintColor(.lightBlue600, renderingMode: .alwaysTemplate), for: .normal)
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
        self.addSubviews([navigationBarView, logoImageView, connectionCheckButton, codeCodyButton, myCodeLabel, codeLabel])

        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        logoImageView.snp.makeConstraints {
            $0.height.width.equalTo(158)
            $0.top.equalTo(navigationBarView.snp.bottom).offset(128)
            $0.centerX.equalToSuperview()
        }
     
        
        connectionCheckButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        codeCodyButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(connectionCheckButton.snp.top).offset(-16)
        }
        myCodeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(47)
            $0.centerX.equalToSuperview()
        }

        codeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
            $0.top.equalTo(myCodeLabel.snp.bottom).offset(16)
        }


    }

}
