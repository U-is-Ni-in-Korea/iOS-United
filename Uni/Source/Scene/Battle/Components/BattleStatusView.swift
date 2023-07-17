import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

class BattleStatusView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
    }
    
    
    /**summary의 유무에 따라 chip 위치 변경**/
    func bindText(sectionTitle: String,
                  title: String,
                  summary: String? = nil,
                  status: BattleStatus = .win) {
        self.sectionTitleLabel.text = sectionTitle
        switch status {
        case .win, .lose, .draw:
            self.missionTitleLabel.text = title
            if let summary = summary {
                self.missionSummaryLabel.text = summary
            } else {
                self.missionSummaryLabel.isHidden = true
            }
        case .progress:
            self.missionTitleLabel.isHidden = true
            self.missionSummaryLabel.isHidden = true
            self.backGroundContentView.backgroundColor = .gray150
            self.defaultLabel.isHidden = false
        }
        
        
    }
    
    /**title유무에 따라, chip의 길이 변경, status로 색 변경**/
    func bindChipText(title: String? = nil,
                      subTitle: String,
                      status: BattleStatus) {
        self.chipView.setTitle(title: title,
                               subTtile: subTitle)
        switch status {
        case .win:
            self.chipView.setConfig(titleColor: .green600,
                                    subTitleColor: .green600,
                                    backGroundColor: .green50)
        case .lose:
            self.chipView.setConfig(titleColor: .pink600,
                                    subTitleColor: .pink600,
                                    backGroundColor: .pink50)
        case .draw, .progress:
            self.chipView.isHidden = true
            break
        }
    }
    
    private func setLayout() {
        self.addSubviews([sectionTitleLabel, backGroundContentView])
        sectionTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        backGroundContentView.snp.makeConstraints {
            $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        backGroundContentView.addSubviews([titleStackView, chipView, defaultLabel])
        titleStackView.addArrangeSubViews([missionTitleLabel, missionSummaryLabel])
        missionTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        missionSummaryLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        chipView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(26)
        }
        defaultLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        defaultLabel.isHidden = true
        
    }
    
    private let sectionTitleLabel = UILabel().then {
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    private let backGroundContentView = UIView().then {
        $0.backgroundColor = .gray000
        $0.layer.cornerRadius = 10
    }
    private let backGroundStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 18
    }
    private let titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 6
    }
    private let missionTitleLabel = UILabel().then {
        $0.font = SDSFont.btn2.font
        $0.textColor = .gray600
    }
    private let missionSummaryLabel = UILabel().then {
        $0.font = SDSFont.caption.font
        $0.textColor = .gray600
    }
    private let defaultLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.numberOfLines = 0
        $0.textColor = .gray300
        $0.textAlignment = .center
        $0.text = "상대가 미션을 끝내면 승부 히스토리에서 확인할 수 있어요."
    }
    private let chipView = BattleChipView()
}
