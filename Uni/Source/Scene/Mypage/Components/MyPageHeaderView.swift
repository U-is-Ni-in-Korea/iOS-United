import UIKit

import SDSKit
import Then

final class MyPageHeaderView: UIView {
    // MARK: - UI Property
    private lazy var headerTitleLabel = UILabel().then {
        $0.textColor = .lightBlue600
        $0.font = SDSFont.body2.font
    }
    // MARK: - Life Cycle
    init(title: String) {
        super.init(frame: .zero)
        self.headerTitleLabel.text = title
        self.setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setting
    private func setLayout() {
        addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(7)
        }
    }
}
