import UIKit
import SDSKit
import Then

final class MyWishView: UIView {
    // MARK: - UI Property
    let captureView = UIView().then {
        $0.backgroundColor = .gray000
    }
    private let nonCaptureView = UIView()
    private let leftBackgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "leftBackground")
    }
    private let rightBackgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "rightBackground")
    }
    private let naviBackgroundView = UIView().then {
        $0.applyNavigationBarShadow()
    }
    let myWishViewNavi = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "나의 소원권")
    var shareWishCouponButton = SDSChips(type: .blue, title: "공유하기 >")
    let myWishCouponView = MyWishCouponView().then {
        $0.layer.cornerRadius = 16
    }
    var useWishCouponButton = SDSButton(type: .fill, state: .enabled).then {
        $0.titleLabel?.textColor = .gray000
        $0.titleLabel?.font = SDSFont.btn1.font
    }
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setting
    private func setLayout() {
        addSubviews([captureView, nonCaptureView])
        captureView.addSubviews([leftBackgroundImageView, rightBackgroundImageView, myWishCouponView, shareWishCouponButton])
        nonCaptureView.addSubviews([naviBackgroundView, myWishViewNavi, shareWishCouponButton, useWishCouponButton])
        captureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        nonCaptureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        leftBackgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        rightBackgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-80)
        }
        myWishViewNavi.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        naviBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(myWishViewNavi.snp.bottom)
        }
        shareWishCouponButton.snp.makeConstraints {
            $0.top.equalTo(myWishViewNavi.snp.bottom).offset(38)
            $0.centerX.equalToSuperview()
        }
        myWishCouponView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(134)
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().inset(37)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-120)
        }
        useWishCouponButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
}
