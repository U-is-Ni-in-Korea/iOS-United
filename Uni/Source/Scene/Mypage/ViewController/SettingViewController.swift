//
//  SettingViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

final class SettingViewController: BaseViewController {

    var settingView = SettingView()
    var userData: UserDataModel?
    private let userRepository = UserRepository()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingViewNaviActions()
        settingViewActions()
    }

    override func loadView() {
        super.loadView()
        setStyle()
    }

}

extension SettingViewController: SettingViewDelegate {

    func setStyle() {
        settingView = SettingView(frame: self.view.frame)
        settingView.delegate = self
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

    @objc func editProfileTapped(_ gesture: UITapGestureRecognizer) {
        let editProfileViewController = EditProfileViewController()
        if let data = self.userData {
            editProfileViewController.dataBind(userName: data.nickname ?? "",
                                               startDate: data.startDate ?? "")
        }
        self.navigationController?.pushViewController(editProfileViewController, animated: true)
    }

    func didSelectCell(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0:  let accountViewController = AccountViewController()
            self.navigationController?.pushViewController(accountViewController, animated: true)
        default:
            return
        }
    }

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
