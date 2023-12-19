import UIKit

final class MyWishViewController: BaseViewController {
    // MARK: - Property
    var wishId: Int = 0
    // MARK: - UI Property
    private let wishRepository = WishRepository()
    var myWishView = MyWishView()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        myWishView = MyWishView(frame: self.view.frame)
        self.view = myWishView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myWishNaviActions()
        myWishShareTapped()
        setUseWishCouponButton()
        getWishCouponData()
    }
    // MARK: - Setting
    private func setUseWishCouponButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(useWishCouponButtonTapped))
        tapGesture.delegate = self
        myWishView.useWishCouponButton.addGestureRecognizer(tapGesture)
        if myWishView.useWishCouponButton.buttonState == .enabled {
            myWishView.useWishCouponButton.setButtonTitle(title: "소원권 사용하기")
        } else {
            myWishView.useWishCouponButton.setButtonTitle(title: "이미 사용한 소원권이에요")
        }
    }
    // MARK: - @objc Methods
    @objc func shareActions(_ gesture: UITapGestureRecognizer) {
        let image = viewToImage(view: myWishView.captureView)
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    @objc func useWishCouponButtonTapped() {
        let alert = self.view.showAlert(title: "소원권을 사용하시나요?",
                                        message: "사용한 소원권은 취소할 수 없어요",
                                        cancelButtonMessage: "취소",
                                        okButtonMessage: "확인",
                                        type: .alert)
        alert.okButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.useWishCoupon { [weak self] in
                strongSelf.view.hideAlert(view: alert)
                let completVC = CompletedWishCouponViewController()
                completVC.modalPresentationStyle = .overFullScreen
                completVC.dismissCompletionHandler = {
                    strongSelf.navigationController?.popToRootViewController(animated: false)
                }
                strongSelf.navigationController?.present(completVC, animated: true)
            }
        }
        alert.cancelButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.view.hideAlert(view: alert)
        }
    }
    // MARK: - Custom Method
    private func dataBindMyWish(wishContent: String,
                        isUsed: Bool,
                        iconPath: String) {
        if let url = URL(string: iconPath) {
            myWishView.myWishCouponView.myWishImageView.kf.setImage(with: url)
        }
        myWishView.myWishCouponView.myWishLabel.text = wishContent
        if isUsed {
            myWishView.useWishCouponButton.buttonState = .disabled
        } else {
            myWishView.useWishCouponButton.buttonState = .enabled
        }
    }
    private func myWishNaviActions() {
        self.myWishView.myWishViewNavi.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)}
    }
    private func myWishShareTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shareActions(_:)))
        myWishView.shareWishCouponButton.addGestureRecognizer(tapGesture)
        myWishView.isUserInteractionEnabled = true
    }
    private func useWishCoupon(completion: @escaping (() -> Void)) {
        self.view.showIndicator()
        wishRepository.useWishCoupon(wishId: wishId) { [weak self] _ in
            guard let strongSelf = self else {return}
            strongSelf.myWishView.useWishCouponButton.buttonState = .disabled
            strongSelf.myWishView.useWishCouponButton.isUserInteractionEnabled = false
            strongSelf.myWishView.useWishCouponButton.setButtonTitle(title: "이미 사용된 소원권이에요")
            strongSelf.view.removeIndicator()
            completion()
        }
    }
    private func getWishCouponData() {
        self.view.showIndicator()
        wishRepository.getWishCouponDetail(wishId: wishId) { [weak self] data in
            guard let strongSelf = self else {return}
            strongSelf.dataBindMyWish(wishContent: data.wishCoupon.content,
                                      isUsed: data.wishCoupon.isUsed,
                                      iconPath: data.wishCoupon.image ?? "")
            if data.wishCoupon.isUsed {
                self?.myWishView.useWishCouponButton.isUserInteractionEnabled = false
            }
            strongSelf.view.removeIndicator()
        }
    }
    func viewToImage(view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
}
// MARK: - Extensions
extension MyWishViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
