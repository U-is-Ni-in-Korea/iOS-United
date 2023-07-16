//
//  SettingViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

class SettingViewController: UIViewController, SettingViewDelegate {

    var settingView = SettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingViewActions()
    }
    
    override func loadView() {
        super.loadView()
        
        settingView = SettingView(frame: self.view.frame)
        settingView.delegate = self
        self.view = settingView
    }
    
    func settingViewActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editProfileTapped(_:)))
        settingView.profileView.editProfileButton.addGestureRecognizer(tapGesture)
        settingView.isUserInteractionEnabled = true
    }
    
    @objc func editProfileTapped(_ gesture: UITapGestureRecognizer) {
        print("tappppppppp")
        let editProfileViewController = EditProfileViewController()
        self.navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :  let accountViewController = AccountViewController()
            self.present(accountViewController,animated: true, completion: nil)
        default:
            return
        }
    }
}
