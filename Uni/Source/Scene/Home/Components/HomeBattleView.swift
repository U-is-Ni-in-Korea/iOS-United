import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

final class HomeBattleView: UIView {
    // MARK: - UI Property
    private let titleLabel = UILabel().then {
        $0.font = SDSFont.title1.font
        $0.textColor = .gray600
        $0.text = "승부하기"
    }
    private let descriptionLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textColor = .gray350
        $0.text = "승부를 겨루고 소원권을 얻어보세요"
    }
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .fillEqually
    }
    let shortBattleButton = HomeBattleSelectView(title: "한판 승부",
                                                 image: UIImage(named: "imgShortGameLogo")!)
    let wishCouponButton = HomeBattleSelectView(title: "소원권",
                                                image: UIImage(named: "imgWishCouponLogo")!)
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
        self.setShadow()
    }
    // MARK: - Setting
    func setBattleState(isPlayingBattle: Bool) {
        if isPlayingBattle {
            self.shortBattleButton.setProgress(progressInfo: "승부 진행 중")
        } else {
            self.shortBattleButton.setProgress(progressInfo: "")
        }
    }
    private func setLayout() {
        self.addSubviews([titleLabel, descriptionLabel, stackView])
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(250)
        }
        stackView.addArrangeSubViews([shortBattleButton, wishCouponButton])
    }
    private func setShadow() {
        shortBattleButton.layer.applyDepth2_1Shadow()
        shortBattleButton.layer.applyDepth1Shadow()
        wishCouponButton.layer.applyDepth2_1Shadow()
        wishCouponButton.layer.applyDepth1Shadow()
    }
}
