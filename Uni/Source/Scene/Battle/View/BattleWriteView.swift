import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

final class BattleWriteView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setOtherMissionViewLayout()
        self.setMyMissionInfoViewLayout()
        self.setLayout()
    }
    
    func bindData() {
        
    }
    
    private func setLayout() {
        self.backgroundColor = .gray100
        self.addSubviews([scrollView, navigationBar])
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalTo(self)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        scrollView.addSubviews([myMissionSectionTitle, myMissionInfoView, otherMissionSectionTitleLabel, otherMissionView, missionCompleteButton, missionFailButton, quitButton])
        
        myMissionSectionTitle.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).offset(16)
            $0.leading.equalTo(self.snp.leading).offset(20)
        }
        myMissionInfoView.snp.makeConstraints {
            $0.top.equalTo(myMissionSectionTitle.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(116)
        }
        otherMissionSectionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(myMissionInfoView.snp.bottom).offset(32)
            $0.leading.equalTo(self.snp.leading).offset(20)
        }
        otherMissionView.snp.makeConstraints {
            $0.top.equalTo(otherMissionSectionTitleLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(116)
        }
        missionCompleteButton.snp.makeConstraints {
            $0.top.equalTo(otherMissionView.snp.bottom).offset(132)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(48)
        }
        missionFailButton.snp.makeConstraints {
            $0.top.equalTo(missionCompleteButton.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(48)
        }
        quitButton.snp.makeConstraints {
            $0.top.equalTo(missionFailButton.snp.bottom).offset(16)
            $0.trailing.equalTo(self.snp.trailing).inset(20)
            $0.height.equalTo(38)
            $0.bottom.equalTo(scrollView.snp.bottom).inset(16)
        }
    }
    
    private func setMyMissionInfoViewLayout() {
        myMissionInfoView.addSubviews([myMissionInfoIconImageView, myMissionTitleLabel, myMissionSummaryLabel, arrowIconImageView])
        
        myMissionInfoIconImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(20)
            $0.width.height.equalTo(77)
        }
        myMissionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(myMissionInfoIconImageView.snp.top).offset(15.5)
            $0.leading.equalTo(myMissionInfoIconImageView.snp.trailing).offset(20)
        }
        myMissionSummaryLabel.snp.makeConstraints {
            $0.bottom.equalTo(myMissionInfoIconImageView.snp.top).inset(15.5)
            $0.leading.equalTo(myMissionInfoIconImageView.snp.trailing).offset(20)
        }
        arrowIconImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        myMissionInfoView.layer.applyDepth4_2Shadow()
    }
    
    private func setOtherMissionViewLayout() {
        otherMissionView.addSubview(otherMissionTitleLabel)
        otherMissionTitleLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    
    let navigationBar = BattleNavigationBar().then {
        $0.bindText(title: "한판 승부 기록")
    }
    let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
        $0.contentInsetAdjustmentBehavior = .never
    }
    //myMissionInfoView
    let myMissionSectionTitle = UILabel().then {
        $0.text = "나의 미션은"
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    let myMissionInfoView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .gray000
    }
    let myMissionInfoIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    let myMissionTitleLabel = UILabel().then {
        $0.font = SDSFont.btn2.font
        $0.textColor = .gray600
    }
    let myMissionSummaryLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textColor = .gray600
    }
    let arrowIconImageView = UIImageView(image: SDSIcon.icChevron.resize(targetSize: .init(width: 24, height: 24)).withTintColor(.gray250, renderingMode: .alwaysTemplate))
    
    //otherMission
    let otherMissionSectionTitleLabel = UILabel().then {
        $0.text = "상대의 미션은"
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    let otherMissionView = UIView().then {
        $0.backgroundColor = .gray150
        $0.layer.cornerRadius = 10
    }
    let otherMissionTitleLabel = UILabel().then {
        $0.text = "상대가 미션을 수행하면 공개"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray300
        $0.textAlignment = .center
    }
    
    let missionCompleteButton = SDSButton(type: .fill, state: .enabled).then {
        $0.setButtonTitle(title: "미션 완료")
    }
    let missionFailButton = SDSButton(type: .line, state: .enabled).then {
        $0.setButtonTitle(title: "미션 실패")
    }
    
    let quitButton = UIButton().then {
        $0.setTitle("승부 그만두기", for: .normal)
        $0.setTitleColor(.gray300, for: .normal)
        $0.titleLabel?.font = SDSFont.body1.font
    }
}
