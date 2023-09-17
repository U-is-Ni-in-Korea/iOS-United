import UIKit

import SDSKit
import SnapKit
import Then

final class ScoreView: UIView {
    // MARK: - UI Property
    let backgroundBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial)).then {
        $0.alpha = 1
    }
    private let titleLabel = UILabel().then {
        $0.font = SDSFont.title1.font
        $0.textColor = .gray000
        $0.text = "커플 스코어"
        $0.textAlignment = .left
    }
    private let chipButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 4, leading: 16, bottom: 4, trailing: 16)
        config.background.backgroundColor = .lightBlue500
        config.background.cornerRadius = 16
        $0.configuration = config
    }
    lazy var historyButton = UIButton().then {
        $0.tintColor = .lightBlue100
        let icon = SDSIcon.icChevron.resize(targetSize: .init(width: 24, height: 24))
        var config = UIButton.Configuration.plain()
        config.image = icon.withTintColor(.lightBlue100,
                                          renderingMode: .alwaysTemplate)
        config.imagePlacement = .trailing
        config.titleAlignment = .leading
        config.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.background.backgroundColor = .clear
        config.attributedTitle = "승부 히스토리"
            .setAttributeString(textColor: .gray000,
                                font: SDSFont.body2.font)
        $0.configuration = config
    }
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    private let winInfoView = ScoreInfoView(separatorLeft: false,
                                            separatorRight: false)
    private let drawInfoView = ScoreInfoView(separatorLeft: false,
                                             separatorRight: false)
    private let loseInfoView = ScoreInfoView(separatorLeft: true,
                                             separatorRight: true)
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    // MARK: - Setting
    private func setLayout() {
        self.addSubviews([backgroundBlurView, titleLabel, chipButton, historyButton, stackView])
        stackView.addArrangeSubViews([winInfoView, loseInfoView, drawInfoView])
        backgroundBlurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        chipButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
        }
        historyButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(historyButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(3)
            $0.height.equalTo(63)
        }
    }
    // MARK: - Custom Method
    func bindData(myScore: Int,
                  partnerScore: Int,
                  drawScore: Int,
                  dDay: Int) {
        winInfoView.bindData(count: myScore,
                             countLabelColor: .lightBlue500,
                             info: "승",
                             infoLabelColor: .gray400)
        loseInfoView.bindData(count: partnerScore,
                             countLabelColor: .gray600,
                             info: "패",
                             infoLabelColor: .gray400)
        drawInfoView.bindData(count: drawScore,
                             countLabelColor: .gray300,
                             info: "무",
                             infoLabelColor: .gray400)
        var config = chipButton.configuration
        config?.attributedTitle = "D+\(dDay)".setAttributeString(textColor: .gray000,
                                                                 font: SDSFont.caption.font)
        chipButton.configuration = config
    }
}
