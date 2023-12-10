import UIKit

import Then
import SDSKit
import CHTCollectionViewWaterfallLayout
import Kingfisher

final class WishCouponCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    static var identifier: String {
        return String(describing: self)
    }
    // MARK: - UI Property
    let newWishCouponView = SDSCardWishView()
    lazy var wishCouponListView = SDSCardWishView()
    private let chipView = UIView().then {
        $0.layer.cornerRadius = 13
        $0.backgroundColor = .lightBlue50
    }
    private let chipLabel = UILabel().then {
        $0.font = SDSFont.caption.font
        $0.textColor = .lightBlue600
    }
    private let newWishImageView = UIImageView().then {
        $0.image = UIImage(named: "newWish")
    }
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setting
    private func setStyle() {
        newWishCouponView.layer.applyDepth2_1Shadow()
        newWishCouponView.layer.applyDepth2_2Shadow()
        wishCouponListView.layer.applyDepth2_1Shadow()
        wishCouponListView.layer.applyDepth2_2Shadow()
    }
    private func setLayout() {
        [newWishCouponView, wishCouponListView].forEach {
            self.contentView.addSubview($0)
        }
        newWishCouponView.addSubviews([newWishImageView, chipView])
        chipView.addSubview(chipLabel)
        newWishCouponView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        wishCouponListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        newWishImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40.adjustedH)
        }
        chipView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(26)
        }
        chipLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    // MARK: - Custom Method
    func configure(with type: SDSCardWishType) {
        if type == .noTitle {
            newWishCouponView.isHidden = false
            wishCouponListView.isHidden = true
        } else {
            newWishCouponView.isHidden = true
            wishCouponListView.isHidden = false
        }
    }
    func configureMyNewCell(myWishCouponData: WishCouponDataModel?) {
        chipLabel.text = "새 소원권 \(myWishCouponData?.newWishCoupon ?? 0)개"
    }
    func configureMyCell(myWishCouponData: WishCouponList?) {
        if let url = URL(string: myWishCouponData?.image ?? "") {
            wishCouponListView.wishImageView.kf.setImage(with: url)
        }
        wishCouponListView.setType(title: myWishCouponData?.content ?? "", type: .title)
        if let isUsed = myWishCouponData?.isUsed {
            wishCouponListView.chipLabel.text = usedCheck(value: isUsed).0
            wishCouponListView.chipView.backgroundColor = usedCheck(value: isUsed).1
            wishCouponListView.chipLabel.textColor = usedCheck(value: isUsed).2
        }
    }
    func usedCheck(value: Bool) -> (String, UIColor, UIColor) {
        return value ? ("소원권 사용 완료", UIColor.gray100, UIColor.gray400): ("소원권 사용하기", UIColor.green50, UIColor.green600)
    }
}
