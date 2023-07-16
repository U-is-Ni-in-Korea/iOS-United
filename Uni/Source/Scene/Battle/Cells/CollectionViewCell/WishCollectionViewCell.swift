import UIKit
import SDSKit
import SnapKit
import Then

class WishCollectionViewCell: UICollectionViewCell {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
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
    
    let couponView = SDSCardWishCoupon()
    let creatButton = SDSButton(type: .fill, state: .disabled).then {
        $0.setButtonTitle(title: "한판 승부 만들기")
    }
}
