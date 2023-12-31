import UIKit

import SDSKit
import SnapKit
import Then

final class HistoryDetailResultMissionView: UIView {
    // MARK: - UI Property
    let battleResultStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 9
    }
    let myHistoryResultView = HistoryStatusView()
    let yourHistoryResultView = HistoryStatusView()
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setStyle()
        setBind()
    }
    // MARK: - Setting
    private func setStyle() {
        self.backgroundColor = .gray100
    }
    private func setLayout() {
        self.addSubview(battleResultStackView)
        battleResultStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        battleResultStackView.addArrangeSubViews([myHistoryResultView, yourHistoryResultView])
    }
    private func setBind() {
        myHistoryResultView.bindText(sectionTitle: "나의 미션", title: "s", status: .win)
        yourHistoryResultView.bindText(sectionTitle: "상대의 미션", title: "s", status: .win)
    }
    // MARK: - Custom Method
    func bindMyMissionData(missionTitle: String,
                           clearAt: String? = nil,
                           status: HistoryStatus = .win) {
        myHistoryResultView.bindText(sectionTitle: "나의 미션",
                                     title: missionTitle,
                                     status: status)
        myHistoryResultView.bindChipText(title: clearAt,
                                         subTitle: "미션 성공",
                                         status: .win)
    }
    func bindYourMissionData(missionTitle: String,
                              clearAt: String? = nil,
                             status: HistoryStatus = .lose) {
        yourHistoryResultView.bindText(sectionTitle: "상대의 미션",
                                       title: missionTitle,
                                       status: status)
        yourHistoryResultView.bindChipText(title: clearAt,
                                           subTitle: "미션 실패",
                                           status: .lose)
    }
}
