import UIKit
import SDSKit
import SnapKit
import Then

protocol CouponTextDelegate: NSObject {
    func getCouponText(text: String)
}
protocol CouponTextStateDelegate: NSObject {
    func checkTextViewState(state: Bool)
}
final class BattleWishCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    var makeButtonTapCompletion: ((SDSButtonState) -> Void)?
    // MARK: - UI Property
    let couponView = BattleWishCouponView()
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
        self.addButtonGesture()
//        self.setCouponConfig()
    }
    // MARK: - Setting
    private func setLayout() {
        self.contentView.addSubview(couponView)
        self.couponView.snp.remakeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.top.centerX.equalToSuperview()
        }
    }
    // MARK: - Action Helper
    func addButtonGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(createButtonTap))
        tapGesture.delegate = self
    }
//    func setCouponConfig() {
//        self.couponView.textViewStateDelegate = self
//    }
    // MARK: - @objc Methods
    @objc private func createButtonTap() {
        guard let completion = makeButtonTapCompletion else {return}
    }
}
// MARK: - Extensions
extension BattleWishCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
//extension BattleWishCollectionViewCell: CouponTextStateDelegate {
//    func checkTextViewState(state: Bool) {
////        self.creatButton.buttonState = state ? .enabled: .disabled
//    }
//}
