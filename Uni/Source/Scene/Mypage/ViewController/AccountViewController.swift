import UIKit

import SDSKit
import Then

final class AccountViewController: BaseViewController {
    // MARK: - Property
    private let accountTitleList = AccountTitle.accountTitleList()
    // MARK: - UI Property
    private var accountView = AccountView()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        setStyle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNaviActions()
        tableViewSetting()
    }
    // MARK: - Setting
    private func setStyle() {
        accountView = AccountView(frame: self.view.frame)
        self.view = accountView
    }
    private func tableViewSetting() {
        accountView.accountTableView.delegate = self
        accountView.accountTableView.dataSource = self
    }
    // MARK: - Action Helper
    func accountNaviActions() {
        self.accountView.accountViewNavi.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)
        }
    }
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountTitleList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.idf, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        cell.accountConfigureCell(accountTitleList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let logoutViewController = LogoutViewController()
            logoutViewController.modalTransitionStyle = .crossDissolve
            logoutViewController.modalPresentationStyle = .overFullScreen
            self.present(logoutViewController, animated: true)
        case 1:
            let withdrawViewController = WithdrawViewController()
            withdrawViewController.modalTransitionStyle = .crossDissolve
            withdrawViewController.modalPresentationStyle = .overFullScreen
            self.present(withdrawViewController, animated: true)
        case 2:
            let disConnectViewController = DisconnectViewController()
            disConnectViewController.modalTransitionStyle = .crossDissolve
            disConnectViewController.modalPresentationStyle = .overFullScreen
            self.present(disConnectViewController, animated: true)
        default:
            return
        }
    }
}
