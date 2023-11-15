import UIKit

import SDSKit
import Then

final class SettingView: UIView {
    // MARK: - UI Property
    let settingViewNavi = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "마이페이지")
    let profileView = MyPageProfileView()
    let myPageTableView = UITableView().then {
        $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.reuseIdentifier)
        $0.rowHeight = 56
        $0.separatorStyle = .none
    }
    private let settingTableHeaderView = SettingTableViewHeaderView()
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyle()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setting
    func setLayout() {
        addSubviews([settingViewNavi, profileView, myPageTableView])

        settingViewNavi.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        profileView.snp.makeConstraints {
            $0.top.equalTo(settingViewNavi.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(148)
        }
        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        settingTableHeaderView.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.width.equalTo(300)
        }
    }
    func setStyle() {
        self.backgroundColor = .gray000
    }
    // MARK: - Custom Method
    func bindData(userName: String) {
        self.profileView.userNameLabel.text = userName
    }
}
