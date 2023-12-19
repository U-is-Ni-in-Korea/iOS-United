import UIKit
import SDSKit
import Then

final class MyWishCouponView: UIView {
    // MARK: - UI Property
    var myWishImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    private let myWishInfoLabel = UILabel().then {
        $0.text = "나의 소원은"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }
    var myWishLabel = UILabel().then {
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    let dashlineStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
        $0.backgroundColor = .clear
    }
    private let expirationEmptyView = UIView()
    private let expirationStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 4
    }
    private let expirationDateTitleLabel = UILabel().then {
        $0.text = "유효기간"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }
    private let expirationDateLabel = UILabel().then {
        $0.text = "우리가 사랑할때까지"
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setting
    private func setLayout() {
        for _ in 0...24 {
            let horizontalView = UIView()
            horizontalView.backgroundColor = .gray200
            self.dashlineStackView.addArrangedSubview(horizontalView)
        }
        self.layer.applyDepthAndDepth3_1Shadow()
        self.applyDepth3_2Shadow()
        expirationStackView.addArrangeSubViews([expirationDateTitleLabel, expirationDateLabel])
        addSubviews([myWishImageView, myWishInfoLabel, myWishLabel, dashlineStackView, expirationEmptyView])
        expirationEmptyView.addSubview(expirationStackView)
        myWishImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalToSuperview().offset(80)
            $0.trailing.equalToSuperview().offset(-80)
            $0.height.equalTo(myWishImageView.snp.width)
        }
        myWishInfoLabel.snp.makeConstraints {
            $0.top.equalTo(myWishImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        myWishLabel.snp.makeConstraints {
            $0.top.equalTo(myWishInfoLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(72)
        }
        dashlineStackView.snp.makeConstraints {
            $0.top.equalTo(myWishLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(3)
        }
        expirationEmptyView.snp.makeConstraints {
            $0.top.equalTo(dashlineStackView)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        expirationStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
