import UIKit
import SafariServices

import SDSKit
import Then

final class SettingViewController: BaseViewController {
    // MARK: - Property
    private var userData: UserDataModel?
    private let userRepository = UserRepository()
    private let myPageTitleList = MyPageTitle.myPageTitleList()
    // MARK: - UI Property
    private var settingView = SettingView()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        setStyle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingViewNaviActions()
        settingViewActions()
        settingView.myPageTableView.delegate = self
        settingView.myPageTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserList()
    }
    // MARK: - Setting
    func setStyle() {
        settingView = SettingView(frame: self.view.frame)
        self.view = settingView
    }
    func settingViewNaviActions() {
        self.settingView.settingViewNavi.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)
        }
    }
    func settingViewActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editProfileTapped(_:)))
        settingView.profileView.editProfileButton.addGestureRecognizer(tapGesture)
        settingView.isUserInteractionEnabled = true
    }
    // MARK: - @objc Methods
    @objc func editProfileTapped(_ gesture: UITapGestureRecognizer) {
        let editProfileViewController = EditProfileViewController()
        if let data = self.userData {
            editProfileViewController.dataBind(userName: data.nickname ?? "",
                                               startDate: data.startDate ?? "")
        }
        self.navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    // MARK: - Custom Method
    private func getUserList() {
        self.view.showIndicator()
        self.userRepository.getUserData { [weak self] data in
            guard let strongSelf = self else {return}
            strongSelf.userData = data
            if let nickname = data.nickname {
                strongSelf.settingView.bindData(userName: nickname)
            }
            strongSelf.view.removeIndicator()
        }
    }
}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageTitleList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.reuseIdentifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }

        cell.myPageConfigureCell(myPageTitleList[indexPath.row])
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row, "???")
        switch indexPath.row {
        case 0:
            let accountViewController = AccountViewController()
                self.navigationController?.pushViewController(accountViewController, animated: true)
        case 1:
            let termsOfUseUrl = NSURL(string: "https://sparkle-uni.notion.site/5852b2d5f5b24121a4b28b93a8d2e5b6?pvs=4")
            let termsOfUseUrlSafariView: SFSafariViewController = SFSafariViewController(url: termsOfUseUrl! as URL)
            self.present(termsOfUseUrlSafariView, animated: true, completion: nil)
        case 2:
            let privacyPolicyUrl = NSURL(string: "https://sparkle-uni.notion.site/aebe71410014461d85c96851bae1d5cb?pvs=4")
            let privacyPolicyUrlUrlSafariView: SFSafariViewController = SFSafariViewController(url: privacyPolicyUrl! as URL)
            self.present(privacyPolicyUrlUrlSafariView, animated: true, completion: nil)
        case 3:
            print("개발자 정보")
        default:
            return
        }
    }
}
