//
//  OnboardingCell.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/10.
//

import UIKit
import SnapKit
import Then

final class OnboardingCell: UICollectionViewCell {
    static let identifier = "OnboardingCell"
    //MARK: - properties
    
    let titleBaseView = UIView()
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
    }
    
    let subTitleLabel = UILabel().then {
        $0.textColor = .black
    }
    
    let onboardingImageView = UIImageView()
    
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        contentView.addSubviews([titleBaseView, onboardingImageView])
        titleBaseView.addSubviews([titleLabel, subTitleLabel])
        
        titleBaseView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(72)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(82)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview()
        }
        onboardingImageView.snp.makeConstraints {
            $0.top.equalTo(titleBaseView.snp.bottom).offset(52)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(UIScreen.main.bounds.width - 40)
            $0.bottom.equalToSuperview()
        }
    }
}
