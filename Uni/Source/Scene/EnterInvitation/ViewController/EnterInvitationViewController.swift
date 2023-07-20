//
//  EnterInvitationViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/15.
//

import Foundation
import UIKit

final class EnterInvitationViewController: BaseViewController {
    // MARK: - Property
    private let coupleJoinRepository = CoupleJoinRepository()

    // MARK: - UI Property
    private var enterInvitationView = EnterInvitationView()
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        enterInvitationView = EnterInvitationView(frame: self.view.frame)
        view = enterInvitationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConfig()
        actions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
            keyboardState(up: false)
        }
    // MARK: - Setting
    override func setLayout() {
        super.setLayout()
    }
    override func setConfig() {
        super.setConfig()
        self.enterInvitationView.invitationTextField.sdsTextfield.delegate = self

    }

    // MARK: - Action Helper
    private func actions() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(connectionButtonTapped))
        tapGesture.delegate = self
        enterInvitationView.connectionButton.addGestureRecognizer(tapGesture)
        enterInvitationView.connectionButton.addTarget(self, action: #selector(connectionButtonTapped), for: .touchUpInside)
        
        enterInvitationView.navigationBarView.backButtonCompletionHandler = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Custom Method
    @objc func connectionButtonTapped() {
        view.showIndicator()
        let code = enterInvitationView.invitationTextField.sdsTextfield.text
        guard let code else { return }
        coupleJoinRepository.postCoupleJoin(code: code) { value in
            print(value, "ddddddd")
            if let value = value {
                if value == "UE1007" {
                    ///옳바르지 않은 코드
                    self.view.removeIndicator()
                    self.enterInvitationView.invitationTextField.errorLabel.text = "입력하신 코드 정보를 찾을 수 없어요"
                    self.enterInvitationView.invitationTextField.errorLabel.textColor = .red500
                    self.enterInvitationView.invitationTextField.sdsTextfield.layer.borderColor = UIColor.red500.cgColor
                    self.enterInvitationView.invitationTextField.errorLabel.isHidden = false
                }
                else {
                    self.view.removeIndicator()
                    print("예외")
                }
            }
            /// 성공
            else {
                print("성공")
                self.view.removeIndicator()
                UserDefaultsManager.shared.save(value: true, forkey: .hasCoupleCode)
                let homeViewController = HomeViewController()
                self.changeRootViewController(UINavigationController(rootViewController: homeViewController))
            }
        }
    }
    
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let height = -keyboardSize.height - 16
            if height < 0 {
                keyboardState(up: true, height: height)
            }
        }
    }
    
    private func keyboardState(up: Bool, height: Double = 0) {
        if up {
            UIView.animate(withDuration: 0.3, animations: {
                self.enterInvitationView.connectionButton.snp.remakeConstraints {
                    $0.bottom.equalToSuperview().offset(height)
                    $0.height.equalTo(48)
                    $0.leading.trailing.equalToSuperview().inset(20)
                }
                self.view.layoutIfNeeded()
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseInOut, animations: {
                self.enterInvitationView.connectionButton.snp.remakeConstraints {
                    $0.height.equalTo(48)
                    $0.leading.trailing.equalToSuperview().inset(20)
                    $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
                }
                self.view.layoutIfNeeded()
            })
        }
    }
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
            print("이거")
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
            print("else")
        }
    }
}

// MARK: - UITableView Delegate
extension EnterInvitationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.enterInvitationView.invitationTextField.sdsTextfield.layer.borderColor = UIColor.lightBlue500.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.enterInvitationView.invitationTextField.sdsTextfield.resignFirstResponder()
        keyboardState(up: false)
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
         guard let currentText = textField.text else { return }
         if currentText.count >= 9 {
             enterInvitationView.connectionButton.buttonState = .enabled
             enterInvitationView.connectionButton.isEnabled = true
         } else {
             enterInvitationView.connectionButton.buttonState = .disabled
             enterInvitationView.connectionButton.isEnabled = false
         }
     }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         guard let currentText = textField.text else { return true }
         let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
         if updatedText.count > 9 {
             return false
         }
         return true
     }
}
extension EnterInvitationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
