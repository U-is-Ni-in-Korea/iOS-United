import UIKit

import SDSKit
import Then

final class LogoutView: UIView {
    // MARK: - UI Property
    let askLogoutAlertView = AlertView(title: "로그아웃 하시겠습니까?", cancelButtonMessage: "취소", okButtonMessage: "로그아웃", type: .alert)
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
        addSubview(askLogoutAlertView)

        askLogoutAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
