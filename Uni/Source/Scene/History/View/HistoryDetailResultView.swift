//
//  HistoryDetailResultView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/15.
//

import UIKit

import SDSKit
import SnapKit
import Then

final class HistoryDetailResultView: UIView {

    // MARK: - UI Property
    
    let gameDateLabel = UILabel().then {
        $0.textColor = .gray400
        $0.font = SDSFont.body2.font
    }
    let gameImageView = UIImageView().then {
        $0.layer.cornerRadius = 8
    }
    let textStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fillProportionally
    }
    let gameNameLabel = UILabel().then {
        $0.textColor = .gray600
        $0.font = SDSFont.subTitle.font
    }
    let gameResultLabel = UILabel().then {
        $0.textColor = .lightBlue500
        $0.font = SDSFont.body2.font
    }
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    // MARK: - Setting

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
}
