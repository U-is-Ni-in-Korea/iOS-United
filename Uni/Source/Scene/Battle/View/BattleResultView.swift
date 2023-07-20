import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

enum ResultButtonType {
    case showWish
    case showHome
}

class BattleResultView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
    }
    
    func bindMyMissionData(missionTitle: String,
                           summary: String? = nil,
                           clearAt: String? = nil,
                           status: BattleStatus = .win) {
//        myBattleResultView.bindText(sectionTitle: "나의미션", title: missionTitle, summary: summary, status: status)
//        myBattleResultView.bindChipText(title: clearAt, subTitle: "미션성공", status: .win)
    }
    
    func bindOtherMissionData(missionTitle: String,
                              summary: String? = nil,
                              clearAt: String? = nil,
                              status: BattleStatus = .progress) {
//        otherBattleResultView.bindText(sectionTitle: "상대의 미션", title: missionTitle, summary: summary, status: status)
//        otherBattleResultView.bindChipText(title: clearAt, subTitle: "미션실패", status: status)
    }
    
    func setButtonConfig(type: ResultButtonType) {
        switch type {
        case .showWish:
            self.resultButton.buttonState = .enabled
            self.resultButton.setButtonTitle(title: "소원권 조회하러 가기")
        case .showHome:
            var config = self.resultButton.configuration
            config?.background.backgroundColor = .clear
            config?.background.strokeColor = .lightBlue500
            config?.background.strokeWidth = 1
            config?.attributedTitle = "홈으로 돌아가기".setAttributeString(textColor: .lightBlue600,
                                                                    font: SDSFont.btn1.font)
            self.resultButton.configuration = config
        }
    }
    
    private func setLayout() {
        self.backgroundColor = .gray100
        self.addSubviews([naviagationBar, scrollView])
        naviagationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(naviagationBar.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(self)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        
        scrollView.addSubviews([battleResultStackView, statusSectionTitle, illustImageView, resultButton])
        battleResultStackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(170)
        }
        battleResultStackView.addArrangeSubViews([myBattleResultView, otherBattleResultView])
        statusSectionTitle.snp.makeConstraints {
            $0.top.equalTo(battleResultStackView.snp.bottom).offset(32)
            $0.height.equalTo(24)
            $0.leading.equalTo(self).offset(20)
        }
        illustImageView.snp.makeConstraints {
            $0.top.equalTo(statusSectionTitle.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(335)
        }
        resultButton.snp.makeConstraints {
            $0.top.equalTo(illustImageView.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(48)
            $0.bottom.equalTo(scrollView.snp.bottom).inset(16)
        }
        
    }
    
    let scrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never
    }
    let naviagationBar = BattleNavigationBar().then {
        $0.bindText(title: "한판 승부 결과")
    }
    let battleResultStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    let myBattleResultView = BattleStatusView()
    let otherBattleResultView = BattleStatusView()
    
    let statusSectionTitle = UILabel().then {
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
        $0.text = ""
    }
    let illustImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    let resultButton = SDSButton(type: .fill, state: .enabled)
}
