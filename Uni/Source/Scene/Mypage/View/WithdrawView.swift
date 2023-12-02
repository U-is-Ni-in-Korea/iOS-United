import UIKit

import SDSKit
import Then

final class WithdrawView: UIView {
    // MARK: - UI Property
    let askWithdrawAlertView = AlertView(title: "계정을 탈퇴하시겠어요?", message: "모든 기록이 사라져요", cancelButtonMessage: "취소", okButtonMessage: "탈퇴", type: .alert)
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setting
    private func setLayout() {
        addSubview(askWithdrawAlertView)
        askWithdrawAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
