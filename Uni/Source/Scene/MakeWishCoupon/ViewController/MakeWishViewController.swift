import UIKit

final class MakeWishViewController: BaseViewController, WriteWishViewDelegate {
    // MARK: - Property
    var makeWishCompletionHandler: (() -> Void)?
    // MARK: - UI Property
    private var makeWishView = MakeWishView()
    private let wishRepository = WishRepository()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        makeWishView = MakeWishView(frame: self.view.frame)
        makeWishView.writeWishView.delegate = self
        self.view = makeWishView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonGesture()
        makeWishActions()
        makeWishView.makeWishButton.setButtonTitle(title: "소원권 생성하기")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.makeWishView.writeWishView.endEditing(true)
    }
    // MARK: - Setting
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
    // MARK: - Action Helper
    private func addButtonGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(makeWishButtonTap))
        tapGesture.delegate = self
        self.makeWishView.makeWishButton.addGestureRecognizer(tapGesture)
    }
    // MARK: - @objc Methods
    @objc private func makeWishButtonTap() {
        self.makeWishCoupon()
    }
    // MARK: - Custom Method
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
// MARK: - Extensions
extension MakeWishViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
