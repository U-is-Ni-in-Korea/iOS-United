//
//  UseWishCouponViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/19.
//

import UIKit

class UseWishCouponViewController: BaseViewController {

    var useWishCouponHandler: (() -> Void)?

    var useWishCouponView = UseWishCouponView()

    override func viewDidLoad() {
        super.viewDidLoad()
        useWishCouponActions()
    }

    override func loadView() {
        super.loadView()

        useWishCouponView = UseWishCouponView(frame: self.view.frame)
        self.view = useWishCouponView
    }

    func useWishCouponActions() {
        self.useWishCouponView.askUseWishCouponAlertView.cancelButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
        }

        self.useWishCouponView.askUseWishCouponAlertView.okButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
            strongSelf.useWishCouponHandler?()
        }
    }
}
