//
//  HistoryDetailResultView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/15.
//

import UIKit
import Then
import SDSKit

final class HistoryDetailResultView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    private let gameDateLabel = UILabel().then {
        $0.text = "23.06.20"
        $0.textColor = .gray400
        $0.font = SDSFont.body2.font
    }
    
    private let gameImageView = UIImageView().then {
        $0.backgroundColor = .gray200 //이미지 변경하기
        $0.layer.cornerRadius = 8
    }
    
    private let textStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fillProportionally
    }
    
    private let gameNameLabel = UILabel().then {
        $0.text = "키워드 스무고개"
        $0.textColor = .gray600
        $0.font = SDSFont.subTitle.font
    }
    
    private let gameResultLabel = UILabel().then {
        $0.text = "철수님이 이겼어요"
        $0.textColor = .lightBlue500
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
        [gameDateLabel, gameImageView, textStackView].forEach {
            self.addSubview($0)
        }
        [gameNameLabel, gameResultLabel].forEach {
            textStackView.addArrangedSubview($0)
        }
        
        gameDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        gameImageView.snp.makeConstraints {
            $0.top.equalTo(gameDateLabel.snp.bottom).offset(22)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(64)
        }
        
        textStackView.snp.makeConstraints {
            $0.centerY.equalTo(gameImageView)
            $0.leading.equalTo(gameImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(18)
        }

    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}