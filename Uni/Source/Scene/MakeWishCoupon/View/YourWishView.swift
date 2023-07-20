//
//  YourWishView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/19.
//

import UIKit
import SDSKit
import Then

class YourWishView: UIView {

    let leftBackgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "leftBackground")
    }
    
    let rightBackgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "rightBackground")
    }
    
    let yourWishBackgroundView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let naviBackgroundView = UIView().then {
        $0.applyNavigationBarShadow()
    }
    
    let yourWishViewNavi = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "상대 소원권")
    
    let shareWishCouponButton = SDSChips(type: .blue, title: "공유하기 >")
    
    let yourWishCouponView = YourWishCouponView().then {
        $0.layer.cornerRadius = 16
    }
    
    public var isCouponUsedLabel = UILabel().then {
        $0.font = SDSFont.body1.font
        $0.textColor = .gray300
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        self.backgroundColor = .gray000
    }
    
    private func setLayout() {
        addSubviews([leftBackgroundImageView,rightBackgroundImageView,yourWishBackgroundView])
        
        yourWishBackgroundView.addSubviews([naviBackgroundView, yourWishViewNavi, shareWishCouponButton, yourWishCouponView, isCouponUsedLabel])
        
        leftBackgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        rightBackgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/7)
        }
        
        yourWishBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
                
        yourWishViewNavi.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        naviBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(yourWishViewNavi.snp.bottom)
        }
        
        shareWishCouponButton.snp.makeConstraints {
            $0.top.equalTo(yourWishViewNavi.snp.bottom).offset(UIScreen.main.bounds.height/21)
            $0.centerX.equalToSuperview()
        }
        
        yourWishCouponView.snp.makeConstraints {
            $0.top.equalTo(shareWishCouponButton.snp.bottom).offset(UIScreen.main.bounds.height/50)
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().inset(37)
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/5)
        }
        
        isCouponUsedLabel.snp.makeConstraints {
            $0.top.equalTo(yourWishCouponView.snp.bottom).offset(UIScreen.main.bounds.height/12)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
        }

    }
    
    func transformViewToImage() -> UIImage {
        
        if let image = UIImage(named: "wishCouponBackground")?.resize(targetSize: .init(width: self.yourWishCouponView.bounds.width, height: self.yourWishCouponView.bounds.height)) {
            self.yourWishCouponView.dashlineStackView.isHidden = true
            self.yourWishCouponView.backgroundColor = UIColor(patternImage: image)
        }
                
        let renderer = UIGraphicsImageRenderer(bounds: yourWishCouponView.bounds)
        return renderer.image {rendererContext in yourWishCouponView.layer.render(in: rendererContext.cgContext)
            
            self.yourWishCouponView.backgroundColor = .none
            self.yourWishCouponView.dashlineStackView.isHidden = false
        }
    }

}
