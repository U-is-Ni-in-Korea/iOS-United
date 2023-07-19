//
//  MakeWishViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit

final class MakeWishViewController: BaseViewController, WriteWishViewDelegate {
    
    var makeWishView = MakeWishView()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeWishActions()
        makeWishView.makeWishButton.setButtonTitle(title: "소원권 만들기")
    }
    
    override func loadView() {
        super.loadView()
        
        makeWishView = MakeWishView(frame: self.view.frame)
        makeWishView.writeWishView.delegate = self
        self.view = makeWishView
    }
    
    func makeWishActions() {
        self.makeWishView.makeWishViewNavi.rightBarRightButtonItemCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)}
    }
    
    func enableTextView() {
        makeWishView.makeWishButton.buttonState = .enabled
    }
    func disableTextView() {
        makeWishView.makeWishButton.buttonState = .disabled
    }
    
    
    
}
