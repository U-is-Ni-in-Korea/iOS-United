//
//  HistoryEmptyView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/14.
//

import UIKit

import SDSKit
import SnapKit
import Then

final class HistoryEmptyView: UIView {
    
    // MARK: - UI Property
    
    private let gameImageView = UIImageView().then {
        $0.image = SDSIcon.icSad.withTintColor(.lightBlue500)
        $0.layer.cornerRadius = 10
    }
    private let gameNoneLabel = UILabel().then {
        $0.text = "승부 히스토리가 없어요"
        $0.textColor = .gray600
        $0.font = SDSFont.title2.font
    }
    private let gameLabel = UILabel().then {
        $0.text = "연인과 승부를 진행해보세요"
        $0.textColor = .gray400
        $0.font = SDSFont.body2.font
    }

    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setStyle()
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setStyle()
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        self.backgroundColor = .gray100
    }
    private func setLayout() {
        [gameImageView, gameNoneLabel, gameLabel].forEach {
            self.addSubview($0)
        }
        gameImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(36)
            $0.top.equalToSuperview().offset(200)
        }
        gameNoneLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(gameImageView.snp.bottom).offset(8)
        }
        gameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(gameNoneLabel.snp.bottom).offset(8)
        }
    }
}
