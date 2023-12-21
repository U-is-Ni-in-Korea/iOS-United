import Foundation
import UIKit
import SDSKit
import Then

final class DDaySettingView: UIView {
    // MARK: - UI Property
    let navigationBarView = SDSNavigationBar(hasBack: true, hasTitleItem: false)
    private let ddayBaseView = UIView()
    private let ddayTitleLabel = UILabel().then {
        $0.text = "두 분의 기념일을 입력하세요"
        $0.textColor = .gray600
        $0.font = SDSFont.subTitle.font
    }
    private let ddaySubTitleLabel = UILabel().then {
        $0.text = "두 분의 시작일은 언제인가요?"
        $0.textColor = .gray350
        $0.font = SDSFont.body2.font
    }
    private let enterInvitationTitleLabel = UILabel().then {
        $0.text = "초대코드를 입력해주세요"
        $0.font = SDSFont.subTitle.font
        $0.textColor = UIColor.gray600
    }
    let dDayDatePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = NSTimeZone.local
        $0.datePickerMode = .date
        $0.maximumDate = Date()
    }
    let nextButton = SDSButton(type: .fill, state: .enabled).then {
        $0.setButtonTitle(title: "다음")
    }
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setLayout()
        self.setConfig()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setLayout()
        self.setConfig()
    }
    // MARK: - Setting
    private func setConfig() {
        self.backgroundColor = UIColor.gray000
    }
    private func setLayout() {
        self.addSubviews([navigationBarView, ddayBaseView, nextButton, dDayDatePicker])
        ddayBaseView.addSubviews([ddayTitleLabel, ddaySubTitleLabel])

        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        ddayBaseView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(navigationBarView.snp.bottom).offset(58)
        }
        ddayTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        ddaySubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(ddayTitleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
        dDayDatePicker.snp.makeConstraints {
            $0.height.equalTo(204)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(ddayBaseView.snp.bottom).offset(52)
        }
    }
}
