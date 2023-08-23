//
//  MyWishCouponView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/18.
//

import UIKit
import SDSKit
import Then

class MyWishView: UIView {

    let leftBackgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "leftBackground")
    }

    let rightBackgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "rightBackground")
    }

    let myWishBackgroundView = UIView().then {
        $0.backgroundColor = .clear
    }

    let naviBackgroundView = UIView().then {
        $0.applyNavigationBarShadow()
    }

    let myWishViewNavi = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "나의 소원권")

    public var shareWishCouponButton = SDSChips(type: .blue, title: "공유하기 >")

    let myWishCouponView = MyWishCouponView().then {
        $0.layer.cornerRadius = 16
    }

    public var useWishCouponButton = SDSButton(type: .fill, state: .enabled).then {
        $0.titleLabel?.textColor = .gray000
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }

    init() {
        super.init(frame: .zero)
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
        addSubviews([leftBackgroundImageView, rightBackgroundImageView, myWishBackgroundView])
        myWishBackgroundView.addSubviews([naviBackgroundView, myWishViewNavi, shareWishCouponButton, myWishCouponView, useWishCouponButton])

        leftBackgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        rightBackgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/7)
        }

        myWishBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        myWishViewNavi.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        naviBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(myWishViewNavi.snp.bottom)
        }

        shareWishCouponButton.snp.makeConstraints {
            $0.top.equalTo(myWishViewNavi.snp.bottom).offset(UIScreen.main.bounds.height/21)
            $0.centerX.equalToSuperview()
        }

        myWishCouponView.snp.makeConstraints {
            $0.top.equalTo(shareWishCouponButton.snp.bottom).offset(UIScreen.main.bounds.height/50)
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().inset(37)
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/5)
        }

        useWishCouponButton.snp.makeConstraints {
            $0.top.equalTo(myWishCouponView.snp.bottom).offset(UIScreen.main.bounds.height/14)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

    }

    func transformViewToImage() -> UIImage {
        if let image = UIImage(named: "wishCouponBackground")?.resize(targetSize: .init(width: self.myWishCouponView.bounds.width, height: self.myWishCouponView.bounds.height)) {
            self.myWishCouponView.dashlineStackView.isHidden = true
            self.myWishCouponView.backgroundColor = UIColor(patternImage: image)
        }

        let renderer = UIGraphicsImageRenderer(bounds: myWishCouponView.bounds)
        return renderer.image {rendererContext in myWishCouponView.layer.render(in: rendererContext.cgContext)
            self.myWishCouponView.backgroundColor = .none
            self.myWishCouponView.dashlineStackView.isHidden = false
        }
    }
}
