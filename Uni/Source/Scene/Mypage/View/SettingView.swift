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
        $0.isScrollEnabled = false
    }
    private let settingTableHeaderView = MyPageHeaderView(title: "서비스 이용")
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
        addSubviews([settingViewNavi, profileView, myPageTableView, settingTableHeaderView])

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
            $0.top.equalTo(settingTableHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        settingTableHeaderView.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.top.equalTo(profileView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
    func setStyle() {
        self.backgroundColor = .gray000
    }
    // MARK: - Custom Method
    func bindData(userName: String, dDay: String) {
        self.profileView.userNameLabel.text = userName
        self.profileView.dDayLabel.text = formatDateString(rawValue: dDay)
    }
    func formatDateString(rawValue: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: rawValue) else { return rawValue }
        dateFormatter.dateFormat = "yyyy.MM.dd (EEEE)"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let formattedDateString = dateFormatter.string(from: date)
        let shortenedDateString = formattedDateString.replacingOccurrences(of: "요일", with: "")
          return shortenedDateString
    }
}
