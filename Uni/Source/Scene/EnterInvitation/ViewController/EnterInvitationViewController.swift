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
    private var enterInvitationView = EnterInvitationView()

    // MARK: - UI Property
    
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
//        enterInvitationView.invitationTextField.sdsTextfield.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - Custom Method
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
    
//    @objc func textfieldDidChange(_ sender: Any) {
//        guard let textFieldText = enterInvitationView.invitationTextField.sdsTextfield.text else {return}
//        if textFieldText.count >= 9 {
//            enterInvitationView.invitationTextField.sdsTextfield.deleteBackward()
//            enterInvitationView.invitationTextField.errorLabel.isHidden = true
//            enterInvitationView.invitationTextField.layer.borderColor = UIColor.lightBlue500.cgColor
//            enterInvitationView.connectionButton.buttonState = .enabled
//        }
//        else {
//            enterInvitationView.connectionButton.buttonState = .disabled
//        }
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = enterInvitationView.invitationTextField.sdsTextfield.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: string)
        print(changedText)
        if changedText.count >= 10 {
            enterInvitationView.invitationTextField.sdsTextfield.deleteBackward()
            enterInvitationView.invitationTextField.errorLabel.isHidden = true
            enterInvitationView.invitationTextField.layer.borderColor = UIColor.lightBlue500.cgColor
            enterInvitationView.connectionButton.buttonState = .enabled
        }
        else {
            enterInvitationView.connectionButton.buttonState = .disabled
        }
        return true
    }
}
