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
        yourWishActions()
    }
    
    override func loadView() {
        super.loadView()
        
        yourWishView = YourWishView(frame: self.view.frame)
        self.view = yourWishView
    }
    
    func yourWishActions() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shareActions(_:)))
        yourWishView.shareWishCouponButton.addGestureRecognizer(tapGesture)
        yourWishView.isUserInteractionEnabled = true
        
        self.yourWishView.yourWishViewNavi.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)}
    }
    
    @objc func shareActions(_ gesture: UITapGestureRecognizer) {
        
        let yourWishCouponImage = yourWishView.transformViewToImage()
        
        let activityViewController = UIActivityViewController(activityItems: [yourWishCouponImage], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        
    }


}
