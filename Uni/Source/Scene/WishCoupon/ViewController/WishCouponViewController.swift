//
//  WishCouponViewController.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/16.
//

import UIKit
import Then
import SDSKit
import CHTCollectionViewWaterfallLayout

class WishCouponViewController: BaseViewController {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    private var wishCouponView = WishCouponView()
    
    private let wishCouponRepository = WishCouponRepository()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        actions()
        backButtonTapped()
    }
    
    override func loadView() {
        super.loadView()
        
        wishCouponView = WishCouponView(frame: self.view.frame)
//        wishCouponView.delegate = self
        self.view = wishCouponView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ///나
        view.showIndicator()
        wishCouponRepository.getWishCouponData(userId: 4) { data in
            print(data)
            self.configureData(wishCouponData: data)
            self.wishCouponView.myWishCouponData = data
            self.view.removeIndicator()
        }
        
        ///너
        wishCouponRepository.getWishCouponData(userId: 7) { data in
            print(data)
            self.wishCouponView.yourWishCouponData = data
        }
    }
    
    // MARK: - Setting
    
    private func setStyle() {
    }
    
    override func setLayout() {
    }
    
    // MARK: - Action Helper
    
    private func actions() {
        wishCouponView.wishCouponCountView.myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        wishCouponView.wishCouponCountView.yourButton.addTarget(self, action: #selector(yourButtonTapped), for: .touchUpInside)
    }
    
    @objc func myButtonTapped() {
        switchToMyWishCouponView(showMyWishCoupon: true)
        print("switchMyButton")
    }
    
    @objc func yourButtonTapped() {
        switchToMyWishCouponView(showMyWishCoupon: false)
        print("switchYourButton")
    }
    
    func backButtonTapped() {
        self.wishCouponView.navigationBar.backButtonCompletionHandler = { self.navigationController?.popViewController(animated: true)
            print("백버튼 클릭해찌!")
        }
    }
    
    // MARK: - Custom Method
    private func switchToMyWishCouponView(showMyWishCoupon: Bool) {
        if showMyWishCoupon {
            /// 나의 소원권
            DispatchQueue.main.async {
                self.wishCouponView.wishCouponEmptyView.noneLabel.text = ""
                self.wishCouponView.wishCouponCollectionView.isHidden = false
                self.wishCouponView.wishCouponYourCollectionView.isHidden = true
                self.wishCouponView.wishCouponCountView.yourButton.setTitleColor(.gray300, for: .normal)
                self.wishCouponView.wishCouponCountView.yourButton.titleLabel?.font = SDSFont.body1Regular.font
                self.wishCouponView.wishCouponCountView.myButton.setTitleColor(.lightBlue600, for: .normal)
                self.wishCouponView.wishCouponCountView.myButton.titleLabel?.font = SDSFont.subTitle.font
                self.wishCouponView.wishCouponCollectionView.scrollToInitialPosition()
            }
        }
        else {
            /// 상대 소원권
            DispatchQueue.main.async {
                var wishCouponYourData: WishCouponDataModel?
                if let count = self.wishCouponView.wishCouponYourCollectionView.wishCouponYourData?.wishCouponList.count {
                    if count == 0 {
                        self.wishCouponView.wishCouponYourCollectionView.isHidden = true
                        self.wishCouponView.wishCouponEmptyView.isHidden = false
                    } else {
                        self.wishCouponView.wishCouponYourCollectionView.isHidden = false
                        self.wishCouponView.wishCouponEmptyView.isHidden = true
                    }
                }
                self.wishCouponView.wishCouponEmptyView.noneLabel.text = "아직 상대의 소원권이 없어요!"
                self.wishCouponView.wishCouponCollectionView.isHidden = true
                self.wishCouponView.wishCouponYourCollectionView.isHidden = false
                self.wishCouponView.wishCouponCountView.myButton.setTitleColor(.gray300, for: .normal)
                self.wishCouponView.wishCouponCountView.myButton.titleLabel?.font = SDSFont.body1Regular.font
                self.wishCouponView.wishCouponCountView.yourButton.setTitleColor(.lightBlue600, for: .normal)
                self.wishCouponView.wishCouponCountView.yourButton.titleLabel?.font = SDSFont.subTitle.font
                self.wishCouponView.wishCouponYourCollectionView.scrollToInitialPosition()
            }
        }
    }
    
    func configureData(wishCouponData: WishCouponDataModel) {
        wishCouponView.wishCouponCountView.countLabel.text = "사용 가능한 소원권이 \(wishCouponData.availableWishCoupon ?? 0)개 있어요"
    }
}

