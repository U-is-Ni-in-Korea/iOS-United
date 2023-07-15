import Foundation
import UIKit
import SDSKit
import Then

final class HomeView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        self.setLayout()
        self.setShadow()
    }
    
    func bindData(myScore: Int,
                  partnerScore: Int,
                  drawScore: Int,
                  dDay: Int,
                  heartCount: Int,
                  isPlayingBattle: Bool) {
        self.scoreView.bindData(myScore: myScore,
                                partnerScore: partnerScore,
                                drawScore: drawScore,
                                dDay: dDay)
        self.battleView.setHeartCount(count: heartCount)
        self.battleView.setBattleState(isPlayingBattle: isPlayingBattle)
    }
    
    private func setLayout() {
        self.backgroundColor = .white
        scoreShadowView.addSubview(scoreView)
        self.addSubviews([topView, scoreShadowView, battleView])
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        scoreShadowView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(72)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(173)
        }
        scoreView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        battleView.snp.makeConstraints {
            $0.top.equalTo(scoreView.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        self.topView.addSubviews([logoImageView, myPageButton])
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        myPageButton.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(36)
        }
    }
    
    private func setShadow() {
        scoreShadowView.layer.applyBlurAndDepth2_1Shadow()
    }
    
    private var topView = UIView().then {
        $0.backgroundColor = .lightBlue500
    }
    lazy var logoImageView = UIImageView(image: SDSIcon.icLogo)
    lazy var myPageButton = UIButton().then {
        $0.tintColor = .gray000
        var config = UIButton.Configuration.plain()
        config.background.cornerRadius = 8
        config.background.backgroundColor = .white.withAlphaComponent(0.4)
        config.image = SDSIcon.icPerson.withTintColor(.gray000,
                                                      renderingMode: .alwaysTemplate)
        $0.configuration = config
    }
    var scoreShadowView = UIView().then {
        $0.backgroundColor = .clear
    }
    var scoreView = ScoreView()
    var battleView = HomeBattleView()
    
}
