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
        myWishBackActions()
        myWishShareTapped()
        setUseWishCouponButton()
    }
    
    override func loadView() {
        super.loadView()
        
        myWishView = MyWishView(frame: self.view.frame)
        self.view = myWishView
    }
    
    func myWishBackActions() {
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
        myWishView.useWishCouponButton.addTarget(self, action: #selector(useWishCouponButtonTapped), for: .touchUpInside)
        
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
        let useWishCouponViewController = UseWishCouponViewController()
        useWishCouponViewController.modalPresentationStyle = .overFullScreen
        useWishCouponViewController.modalTransitionStyle = .crossDissolve
            self.present(useWishCouponViewController, animated: true, completion: nil)
    }
}
