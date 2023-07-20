//
//  SDSCardWishView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/20.
//

import UIKit
import SnapKit
import SDSKit

public class SDSCardWishView: UIView {
    
    let wishBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray000
        view.layer.cornerRadius = 10
        return view
    }()
    
    let wishImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray100
        return image
    }()
    
    let wishTitleLabel: UILabel = {
        let label = UILabel()
        label.font = SDSFont.body2.font
        label.textColor = .gray600
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let chipView: UIView = {
        let chipView = UIView()
        chipView.layer.cornerRadius = 13
        chipView.layer.masksToBounds = true
        return chipView
    }()
    
    let chipLabel: UILabel = {
        let chip = UILabel()
        chip.font = SDSFont.caption.font
        chip.textAlignment = .center
        return chip
    }()
    
    public init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubview(wishBackgroundView)
        [wishImageView, wishTitleLabel, chipView] .forEach{wishBackgroundView.addSubview($0)}
        
        wishBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        wishImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height/7)
        }
        wishTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(chipView.snp.top)
        }
        //        wishTitleLabel.backgroundColor = .red
        chipView.snp.makeConstraints {
            //            $0.top.equalTo(wishTitleLabel.snp.bottom)
            $0.height.equalTo(26)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
        }
        //        chipView.backgroundColor = .blue
        chipView.addSubview(chipLabel)
        
        chipLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        
    }
    
    func setType(title: String, type: SDSCardWishType) {
        switch type{
        case .title:
            
            wishImageView.snp.remakeConstraints {
                $0.width.height.equalTo(80)
                $0.top.equalToSuperview().offset(28)
                $0.centerX.equalToSuperview()
            }
            
            wishTitleLabel.text = title
            wishTitleLabel.isHidden = false
            wishTitleLabel.snp.remakeConstraints {
                $0.height.equalTo(40)
                $0.leading.trailing.equalToSuperview().inset(12)
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(chipView.snp.top)
            }
            chipView.snp.makeConstraints {
                $0.height.equalTo(26)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().inset(24)
            }
            chipView.backgroundColor = .blue
            chipView.layer.cornerRadius = 13
            chipView.layer.masksToBounds = true
            chipView.addSubview(chipLabel)
            
            chipLabel.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview()
            }
        case .noTitle:
            
            self.snp.remakeConstraints {
                $0.width.equalTo(160)
                $0.height.equalTo(122)
            }
            
            wishImageView.snp.remakeConstraints {
                $0.width.height.equalTo(40)
                $0.top.equalToSuperview().offset(24)
            }
            wishTitleLabel.isHidden = true
        }
    }
}
