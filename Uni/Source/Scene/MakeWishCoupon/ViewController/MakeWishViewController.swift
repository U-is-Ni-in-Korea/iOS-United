//
//  MakeWishViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit

final class MakeWishViewController: BaseViewController, WriteWishViewDelegate {
    
    private var makeWishView = MakeWishView()
    private let wishRepository = WishRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeWishActions()
        addButtonGesture()
        makeWishView.makeWishButton.setButtonTitle(title: "소원권 만들기")
    }
    
    override func loadView() {
        super.loadView()
        
        makeWishView = MakeWishView(frame: self.view.frame)
        makeWishView.writeWishView.delegate = self
        self.view = makeWishView
    }
    
    private func makeWishCoupon() {
        if let content = makeWishView.writeWishView.writeWishTextView.text {
            wishRepository.makeWishCoupon(content: content) { [weak self] in
                guard let strongSelf = self else {return}
            }
        }
    }
    
    private func addButtonGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(makeWishButtonTap))
        tapGesture.delegate = self
        self.makeWishView.makeWishButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func makeWishButtonTap() {
        self.makeWishButtonTap()
    }
    
    private func makeWishActions() {
        self.view.showIndicator()
        self.makeWishView.makeWishViewNavi.rightBarRightButtonItemCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)
            strongSelf.view.removeIndicator()
            
//            strongSelf.dismiss(animated: true)
        }
    }
    
    func enableTextView() {
        makeWishView.makeWishButton.buttonState = .enabled
    }
    func disableTextView() {
        makeWishView.makeWishButton.buttonState = .disabled
    }
    
}
extension MakeWishViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
