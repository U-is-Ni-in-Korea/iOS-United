//
//  HistoryChipView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/19.
//

import UIKit
import SDSKit
import Then

final class HistoryChipView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 6
    }
    private let titleLabel = UILabel().then {
        $0.font = SDSFont.caption.font
    }
    private let subTitleLabel = UILabel().then {
        $0.font = SDSFont.caption.font
    }
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        self.layer.cornerRadius = 13
        self.clipsToBounds = true
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        stackView.addArrangeSubViews([titleLabel, subTitleLabel])
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
    func setTitle(title: String? = nil,
                  subTtile: String) {
        if let title {
            self.titleLabel.text = title
        } else {
            self.titleLabel.isHidden = true
        }
        self.subTitleLabel.text = subTtile
    }
    
    func setConfig(titleColor: UIColor,
                   subTitleColor: UIColor,
                   backGroundColor: UIColor) {
        self.titleLabel.textColor = titleColor
        self.subTitleLabel.textColor = subTitleColor
        DispatchQueue.main.async {
            self.backgroundColor = backGroundColor
        }
    }
}
