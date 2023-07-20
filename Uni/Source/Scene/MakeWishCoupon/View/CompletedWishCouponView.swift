//
//  CompletedWishCoupon.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/19.
//

import UIKit
import Then
import SDSKit

final class CompletedWishCouponView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    let makeWishViewNavi = SDSNavigationBar(hasBack: false, hasTitleItem: false, navigationTitle: "소원권 사용 완료!", rightBarButtonImages: [SDSIcon.icDismiss])
    
    var homeButton = SDSButton(type: .fill, state: .enabled).then {
        $0.setButtonTitle(title: "홈으로 돌아가기")
    }
    
    var completedImageView = UIImageView().then {
        $0.image = UIImage(named: "completedWish")
    }
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setStyle()
        setLayout()
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        self.backgroundColor = .gray100
    }
    
    private func setLayout() {
        [makeWishViewNavi, completedImageView, homeButton].forEach { addSubview($0) }
        
        makeWishViewNavi.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        completedImageView.snp.makeConstraints {
            $0.height.width.equalTo(UIScreen.main.bounds.width / 372 * 335)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        homeButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}
