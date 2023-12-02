import UIKit

import SDSKit
import Then

final class AccountView: UIView {
    // MARK: - UI Property
    public var accountViewNavi = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "계정")
    let accountTableView = UITableView().then {
        $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.idf)
        $0.rowHeight = 56
        $0.separatorStyle = .none
    }
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
        addSubviews([accountViewNavi, accountTableView])

        accountViewNavi.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        accountTableView.snp.makeConstraints {
            $0.top.equalTo(accountViewNavi.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
