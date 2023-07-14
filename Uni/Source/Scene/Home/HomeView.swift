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
    }
    
    func bindData(myScore: Int,
                  partnerScore: Int,
                  drawScore: Int,
                  dDay: Int) {
        self.scoreView.bindData(myScore: myScore,
                                partnerScore: partnerScore,
                                drawScore: drawScore,
                                dDay: dDay)
    }
    
    private func setLayout() {
        self.backgroundColor = .white
        self.addSubviews([topView, scoreView])
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        scoreView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(72)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(173)
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
    
    private var topView = UIView().then {
        $0.backgroundColor = .lightBlue500
    }
    lazy var logoImageView = UIImageView(image: .init(named: "sparkleLogo"))
    lazy var myPageButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.background.cornerRadius = 8
        config.background.backgroundColor = .white.withAlphaComponent(0.4)
        config.image = SDSIcon.icPerson
//        config.image = UIImage(named: "icon")?.withTintColor(.lightBlue200)
        $0.configuration = config
    }
    var scoreView = ScoreView()
    
}
