//
//  MyWishCouponViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/19.
//

import UIKit

class MyWishViewController: BaseViewController {
    
    var myWishView = MyWishView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWishNaviActions()
        myWishShareTapped()
        setUseWishCouponButton()
        getWishCouponData()
    }
    
    override func loadView() {
        super.loadView()
        
        myWishView = MyWishView(frame: self.view.frame)
        self.view = myWishView
    }
    
    func dataBindMyWish(wishContent: String, isUsed: Bool) {
        myWishView.myWishCouponView.myWishLabel.text = wishContent
        if isUsed {
            myWishView.useWishCouponButton.buttonState = .disabled
        } else {
            myWishView.useWishCouponButton.buttonState = .enabled
        }
    }
    
    func myWishNaviActions() {
        self.myWishView.myWishViewNavi.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)}
    }
    
    func myWishShareTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shareActions(_:)))
        myWishView.shareWishCouponButton.addGestureRecognizer(tapGesture)
        myWishView.isUserInteractionEnabled = true
    }
    
    func setUseWishCouponButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(useWishCouponButtonTapped))
        tapGesture.delegate = self
        myWishView.useWishCouponButton.addGestureRecognizer(tapGesture)
        
        if myWishView.useWishCouponButton.buttonState == .enabled {
            myWishView.useWishCouponButton.setButtonTitle(title: "소원권 사용하기")
        } else {
            myWishView.useWishCouponButton.setButtonTitle(title: "이미 사용한 소원권이에요")
        }
    }
    
    @objc func shareActions(_ gesture: UITapGestureRecognizer) {
        let myWishCouponImage = myWishView.transformViewToImage()
        
        let activityViewController = UIActivityViewController(activityItems: [myWishCouponImage], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController?.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func useWishCouponButtonTapped() {
        let alert = self.view.showAlert(title: "소원권을 사용하시나요?",
                                        message: "사용하신 소원권은 돌아오지 않아요",
                                        cancelButtonMessage: "취소",
                                        okButtonMessage: "확인",
                                        type: .alert)
        alert.okButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.useWishCoupon { [weak self] in
                strongSelf.view.hideAlert(view: alert)
                let completVC = CompletedWishCouponViewController()
                completVC.modalPresentationStyle = .overFullScreen
                completVC.dismissCompletionHandler = {
                    strongSelf.navigationController?.popToRootViewController(animated: false)
                }
                strongSelf.navigationController?.present(completVC, animated: true)
            }
        }
        
        alert.cancelButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.view.hideAlert(view: alert)
        }
    }
    
    private func useWishCoupon(completion: @escaping (() -> Void)) {
        self.view.showIndicator()
        wishRepository.useWishCoupon(wishId: wishId) { [weak self] data in
            guard let strongSelf = self else {return}
            strongSelf.myWishView.useWishCouponButton.buttonState = .disabled
            strongSelf.myWishView.useWishCouponButton.isUserInteractionEnabled = false
            strongSelf.myWishView.useWishCouponButton.setButtonTitle(title: "이미 사용된 소원권이에요")
            strongSelf.view.removeIndicator()
            completion()
        }
    }
    
    private func getWishCouponData() {
        self.view.showIndicator()
        wishRepository.getWishCouponDetail(wishId: wishId) { [weak self] data in
            guard let strongSelf = self else {return}
            strongSelf.dataBindMyWish(wishContent: data.wishCoupon.content,
                                      isUsed: data.wishCoupon.isUsed)
            if data.wishCoupon.isUsed {
                self?.myWishView.useWishCouponButton.isUserInteractionEnabled = false
            }
            strongSelf.view.removeIndicator()
        }
    }
    
    private let wishRepository = WishRepository()
    var wishId: Int = 0
}
extension MyWishViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
