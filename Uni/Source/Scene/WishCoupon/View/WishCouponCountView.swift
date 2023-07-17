//
//  WishCouponCountView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/16.
//

import UIKit
import Then
import SDSKit

final class WishCouponCountView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    private let messageLabel = UILabel().then {
        $0.text = "남은 소원권을 사용해보세요!"
        $0.textColor = .gray600
        $0.font = SDSFont.subTitle.font
    }
    
    private let countLabel = UILabel().then {
        $0.text = "사용 가능한 소원권이 6개 있어요" // 서버에서 받아오는 값 생각하기
        $0.textColor = .gray350
        $0.font = SDSFont.body2.font
    }
    
    let myButton = UIButton().then {
        $0.setTitle("나의 소원권", for: .normal)
        $0.setTitleColor(.lightBlue600, for: .normal)
        $0.titleLabel?.font = SDSFont.subTitle.font
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .gray200
    }
    
    let yourButton = UIButton().then {
        $0.setTitle("상대 소원권", for: .normal)
        $0.setTitleColor(.gray300, for: .normal)
        $0.titleLabel?.font = SDSFont.body1Regular.font
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
        [messageLabel, countLabel, myButton, lineView, yourButton].forEach {
            addSubview($0)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        myButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(97)
            $0.height.equalTo(38)
            $0.leading.equalToSuperview().inset(20)
        }
        
        lineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(16)
            $0.leading.equalTo(myButton.snp.trailing)
            $0.centerY.equalTo(myButton)
        }
        
        yourButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(97)
            $0.height.equalTo(38)
            $0.leading.equalTo(lineView.snp.trailing)
        }
    }
    
    // MARK: - Action Helper
    
//    @objc private func myButtonTapped() {
//        let wishCouponCollectionView = WishCouponCollectionView()
//        navigationController?.pushViewController(wishCouponCollectionView, animated: true)
//    }
//    
//    @objc private func youtButtonTapped() {
//        let wishCouponYourCollectionView = wishCouponYoutCollectionView()
//        navigationController?.pushViewController(wishCouponYourCollectionView, animated: true)
//    }
    
    // MARK: - Custom Method
    
}
