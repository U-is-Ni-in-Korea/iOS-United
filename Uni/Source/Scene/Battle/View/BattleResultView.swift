import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

class BattleResultView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
        bindMyMissionData(missionTitle: "나의 미션", clearAt: "23: 22")
        bindOtherMissionData(missionTitle: "나의 미션", summary: "미션 내용")
    }
    
    func bindMyMissionData(missionTitle: String,
                           summary: String? = nil,
                           clearAt: String? = nil,
                           status: BattleStatus = .win) {
        myBattleResultView.bindText(sectionTitle: "나의미션", title: missionTitle, summary: summary, status: status)
        myBattleResultView.bindChipText(title: clearAt, subTitle: "미션성공", status: .win)
    }
    
    func bindOtherMissionData(missionTitle: String,
                              summary: String? = nil,
                              clearAt: String? = nil,
                              status: BattleStatus = .progress) {
        otherBattleResultView.bindText(sectionTitle: "상대의 미션", title: missionTitle, summary: summary, status: status)
        otherBattleResultView.bindChipText(title: clearAt, subTitle: "미션실패", status: status)
    }
    
    func setButtonConfig(state: SDSButtonState, buttonTitle: String) {
        self.resultButton.setButtonTitle(title: buttonTitle)
        self.resultButton.buttonState = state
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
        $0.text = "멋진 승리네요!"
    }
    let illustImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = SDSIcon.icAppleLogin
    }
    let resultButton = SDSButton(type: .fill, state: .enabled)
}
