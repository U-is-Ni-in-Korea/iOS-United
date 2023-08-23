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

    var makeWishCompletionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonGesture()
        makeWishActions()
        makeWishView.makeWishButton.setButtonTitle(title: "소원권 만들기")
    }

    override func loadView() {
        super.loadView()

        makeWishView = MakeWishView(frame: self.view.frame)
        makeWishView.writeWishView.delegate = self
        self.view = makeWishView
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.makeWishView.writeWishView.endEditing(true)
    }

    private func makeWishCoupon() {
        if let content = makeWishView.writeWishView.writeWishTextView.text {
            if content.count > 0 && content != makeWishView.writeWishView.writeWishPlaceholder {
                wishRepository.makeWishCoupon(content: content) { [weak self] _ in
                    guard let strongSelf = self else {return}
                    strongSelf.makeWishCompletionHandler?()
                    strongSelf.dismiss(animated: true)
                }
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
        self.makeWishCoupon()
    }

    private func makeWishActions() {
        self.makeWishView.makeWishViewNavi.rightBarRightButtonItemCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
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
