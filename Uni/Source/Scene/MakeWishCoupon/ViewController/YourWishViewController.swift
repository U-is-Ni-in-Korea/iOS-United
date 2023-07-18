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
        self.yourWishView.yourWishViewNavi.backButtonCompletionHandler = { [self] in self.navigationController?.popViewController(animated: true)}
    }


}
