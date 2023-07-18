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
        myWishActions()
        myWishView.useWishCouponButton.setButtonTitle(title: "소원권 사용하기")
    }
    
    override func loadView() {
        super.loadView()
        self.view = myWishView
    }
    
    func myWishActions() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shareActions(_:)))
        myWishView.shareWishCouponButton.addGestureRecognizer(tapGesture)
        myWishView.isUserInteractionEnabled = true
        
        self.myWishView.myWishViewNavi.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)}
    }
    
    @objc func shareActions(_ gesture: UITapGestureRecognizer) {
        
        let myWishCouponImage = myWishView.transformViewToImage()
        
        let activityViewController = UIActivityViewController(activityItems: [myWishCouponImage], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        
    }

}
