import UIKit

import SDSKit
import Then

final class MyPageProfileView: UIView {
    // MARK: - UI Property
    let userNameLabel = UILabel().then {
        $0.font = SDSFont.title2.font
        $0.textColor = .gray600
    }
    let dDayLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textColor = .gray600
    }
    lazy var editProfileButton = UIButton().then {
        $0.setImage(UIImage(named: "pencil"), for: .normal)
    }
    private let headerView = MyPageHeaderView(title: "내 정보")
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setting
    private func setStyle() {
        self.backgroundColor = .gray000
    }
    private func setLayout() {
        [headerView, userNameLabel, editProfileButton, dDayLabel] .forEach { addSubview($0)}
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(34)
        }
        userNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(headerView.snp.bottom).offset(13)
        }
        dDayLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
