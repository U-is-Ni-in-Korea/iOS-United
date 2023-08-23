//
//  YourWishViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/19.
//

import UIKit

class YourWishViewController: BaseViewController {

    var yourWishView = YourWishView()
    let wishRepository = WishRepository()
    var wishId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        yourWishBackActions()
        yourWishShareTapped()
        getWishDetail()
    }

    override func loadView() {
        super.loadView()
        yourWishView = YourWishView(frame: self.view.frame)
        self.view = yourWishView
    }

    private func getWishDetail() {
        wishRepository.getWishCouponDetail(wishId: wishId) { [weak self] data in
            guard let strongSelf = self else {return}
            strongSelf.dataBindYourWish(wishContent: data.wishCoupon.content,
                                        isUsed: data.wishCoupon.isUsed,
                                        iconPath: data.wishCoupon.image ?? "")
            strongSelf.dataBindYourName(nickname: data.nickname)
            strongSelf.isYourWishCouponUsed(data.wishCoupon.isUsed)
        }
    }

    func dataBindYourWish(wishContent: String,
                          isUsed: Bool,
                          iconPath: String) {
        if let url = URL(string: iconPath) {
            yourWishView.yourWishCouponView.yourWishImageView.kf.setImage(with: url)
        }
        yourWishView.yourWishCouponView.yourWishLabel.text = wishContent
        isYourWishCouponUsed(isUsed)
    }

    func dataBindYourName(nickname: String) {
        yourWishView.yourWishCouponView.yourWishIsLabel.text = "\(nickname) 소원은"
    }

    func yourWishBackActions() {
        self.yourWishView.yourWishViewNavi.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)}
    }

    func yourWishShareTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shareActions(_:)))
        yourWishView.shareWishCouponButton.addGestureRecognizer(tapGesture)
        yourWishView.isUserInteractionEnabled = true
    }

    func isYourWishCouponUsed(_ isUsed: Bool) {
        if isUsed {
            yourWishView.isCouponUsedLabel.text = "이미 사용한 소원권이에요"
        } else {
            yourWishView.isCouponUsedLabel.text = "상대가 아직 사용하지 않은 소원권이에요"
        }
    }

    @objc func shareActions(_ gesture: UITapGestureRecognizer) {
        let yourWishCouponImage = yourWishView.transformViewToImage()
        let activityViewController = UIActivityViewController(activityItems: [yourWishCouponImage], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController?.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
}
