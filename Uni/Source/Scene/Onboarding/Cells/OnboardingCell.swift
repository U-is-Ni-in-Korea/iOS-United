//
//  OnboardingCell.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/10.
//

import UIKit
import SnapKit
import Then
import SDSKit

final class OnboardingCell: UICollectionViewCell {
    static let identifier = "OnboardingCell"
    //MARK: - properties
    
    let titleBaseView = UIView()
    
    let titleLabel = UILabel().then {
        $0.textColor = .gray600
        $0.font = SDSFont.subTitle.font
    }
    
    let subTitleLabel = UILabel().then {
        $0.textColor = .gray350
        $0.font = SDSFont.body2.font
        
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
            $0.top.equalToSuperview().inset(88.adjustedH)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        onboardingImageView.snp.makeConstraints {
            $0.top.equalTo(titleBaseView.snp.bottom).offset(68.adjustedH)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(UIScreen.main.bounds.size.width - 40)
            $0.bottom.equalToSuperview()
        }
    }
    func configureCell(_ onboardingModel: OnboardingDataModel) {
        titleLabel.text = onboardingModel.title
        subTitleLabel.text = onboardingModel.subTitle
        onboardingImageView.image = UIImage(named: onboardingModel.image)
    }
}
