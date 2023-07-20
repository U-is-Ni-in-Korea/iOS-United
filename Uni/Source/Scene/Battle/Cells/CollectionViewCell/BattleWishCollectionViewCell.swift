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

class BattleWishCollectionViewCell: UICollectionViewCell {
    var makeButtonTapCompletion: ((SDSButtonState) -> Void)?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
        self.addButtonGesture()
        self.setCouponConfig()
    }
    
    
    private func setLayout() {
        self.contentView.addSubviews([couponView, creatButton])
        self.couponView.snp.remakeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.top.centerX.equalToSuperview()
        }
        self.creatButton.snp.makeConstraints {
            $0.top.equalTo(self.couponView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.height.equalTo(48)
        }
    }
    
    func addButtonGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(createButtonTap))
        tapGesture.delegate = self
        self.creatButton.addGestureRecognizer(tapGesture)
    }
    
    func setCouponConfig() {
        self.couponView.textViewStateDelegate = self
    }
    
    @objc private func createButtonTap() {
        guard let completion = makeButtonTapCompletion else {return}
        completion(creatButton.buttonState)
    }
    
    let couponView = BattleWishCouponView()
    let creatButton = SDSButton(type: .fill, state: .disabled).then {
        $0.setButtonTitle(title: "한판 승부 만들기")
    }
}
extension BattleWishCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
extension BattleWishCollectionViewCell: CouponTextStateDelegate {
    func checkTextViewState(state: Bool) {
        self.creatButton.buttonState = state ? .enabled: .disabled
    }
}
