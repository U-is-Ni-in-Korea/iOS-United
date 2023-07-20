//
//  CoupleConnectionMethodViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import Foundation
import UIKit

final class CoupleConnectionMethodViewController: BaseViewController {
    // MARK: - Property
    private var coupleConnectionMethodView = CoupleConnectionMethodView()

    // MARK: - UI Property
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        coupleConnectionMethodView = CoupleConnectionMethodView(frame: self.view.frame)
        view = coupleConnectionMethodView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConfig()
        actions()
    }
    // MARK: - Setting
    override func setLayout() {
        super.setLayout()
    }
    override func setConfig() {
        super.setConfig()
    }
//enterInvitationCodeButton
    //sendInvitationCodeButton
    // MARK: - Action Helper
    private func actions() {
        let enterInvitationCodeButtonTapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(enterInvitationCodeButtonTapped))
        enterInvitationCodeButtonTapGesture.delegate = self
        coupleConnectionMethodView.enterInvitationCodeButton.addGestureRecognizer(enterInvitationCodeButtonTapGesture)
        let sendInvitationCodeButtonTapGesture = UITapGestureRecognizer(target: self,
                                                                        action: #selector(sendInvitationCodeButtonTapped))
        sendInvitationCodeButtonTapGesture.delegate = self
        coupleConnectionMethodView.sendInvitationCodeButton.addGestureRecognizer(sendInvitationCodeButtonTapGesture)
        coupleConnectionMethodView.enterInvitationCodeButton.addTarget(self, action: #selector(enterInvitationCodeButtonTapped), for: .touchUpInside)
        coupleConnectionMethodView.sendInvitationCodeButton.addTarget(self, action: #selector(sendInvitationCodeButtonTapped), for: .touchUpInside)
        
        coupleConnectionMethodView.navigationBarView.backButtonCompletionHandler = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Custom Method
    
    @objc func sendInvitationCodeButtonTapped() {
        let dDaySettingViewController = DDaySettingViewController()
        navigationController?.pushViewController(dDaySettingViewController, animated: true)
    }
    
    @objc func enterInvitationCodeButtonTapped() {
        print("ddd")
        let enterInvitationViewController = EnterInvitationViewController()
        navigationController?.pushViewController(enterInvitationViewController, animated: true)
    }
}

// MARK: - UITableView Delegate
extension CoupleConnectionMethodViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
