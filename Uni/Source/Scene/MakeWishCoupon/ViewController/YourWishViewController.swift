//
//  YourWishViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/19.
//

import UIKit

class YourWishViewController: BaseViewController {
    
    var yourWishView = YourWishView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yourWishBackActions()
        yourWishShareTapped()
        isYourWishCouponUsed()
    }
    
    override func loadView() {
        super.loadView()
        
        yourWishView = YourWishView(frame: self.view.frame)
        self.view = yourWishView
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
    
    func isYourWishCouponUsed() {
        yourWishView.isCouponUsedLabel.text = "이미 사용한 소원권이에요" //서버 isUsed Boolean 값 받아서 분기 처리 하기
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
