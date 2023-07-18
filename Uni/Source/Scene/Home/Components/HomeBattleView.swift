import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

final class HomeBattleView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        self.setLayout()
        self.setShadow()
    }
    
    func setHeartCount(count: Int) {
        var config = self.heartButton.configuration
        config?.attributedTitle = "x\(count)".setAttributeString(textColor: .lightBlue600,
                                                                 font: SDSFont.btn2.font)
        config?.image = count > 0 ? SDSIcon.icHeartFill: SDSIcon.icHeartEmpty
        self.heartButton.configuration = config
    }
    
    func setBattleState(isPlayingBattle: Bool) {
        if isPlayingBattle {
            self.shortBattleButton.setProgress(progressInfo: "승부 진행 중")
        } else {
            self.shortBattleButton.setProgress(progressInfo: "")
        }
    }
    
    private func setLayout() {
        self.addSubviews([titleLabel, descriptionLabel, heartButton, stackView])
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        heartButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.top).offset(7)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-7)
        }
        heartButton.layer.applyDepth1Shadow()
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
    private let heartButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .gray000
        config.background.cornerRadius = 10
        config.image = SDSIcon.icHeartFill
        config.imagePlacement = .leading
        config.imagePadding = 6
        $0.configuration = config
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
}
