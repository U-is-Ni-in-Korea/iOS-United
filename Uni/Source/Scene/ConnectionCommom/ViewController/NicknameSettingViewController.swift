//
//  NicknameSettingViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/14.
//

import Foundation
import UIKit

final class NicknameSettingViewController: BaseViewController {
    // MARK: - Property
    private let keyChains = HeaderUtils()
    private let userRepository = UserRepository()
    
    private var textCount = 0 {
        didSet {
            print(textCount)
            
            if textCount >= 11 {
                nicknameSettingView.nextButton.buttonState = .disabled
            }
            else {
                nicknameSettingView.nextButton.buttonState = .enabled
            }
        }
    }

    // MARK: - UI Property
    private var nicknameSettingView = NicknameSettingView()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        nicknameSettingView = NicknameSettingView(frame: self.view.frame)
        view = nicknameSettingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConfig()
        actions()
        
//        let key = keyChains.read(account: "accessToken")
//        if let key = key {
//            userRepository.patchUser(token: key, nickname: "창휘창휘") { response in
//                if response {
//                    print("성공!")
//                    let coupleConnectionMethodViewController = CoupleConnectionMethodViewController()
//                    self.navigationController?.pushViewController(coupleConnectionMethodViewController, animated: true)
//                }
//            }
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        keyboardState(up: false)
        nicknameSettingView.nickNameTextField.sdsTextfield.layer.borderColor = UIColor.gray200.cgColor
    }
    
    // MARK: - Setting
    override func setLayout() {
        super.setLayout()
    }
    override func setConfig() {
        super.setConfig()
        nicknameSettingView.nickNameTextField.sdsTextfield.delegate = self
        nicknameSettingView.nickNameTextField.sdsTextfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
    }

    // MARK: - Action Helper
    private func actions() {
        nicknameSettingView.navigationBarView.backButtonCompletionHandler = {
            let isTokenExists = self.keyChains.isTokenExists(account: "accessToken")
            if isTokenExists {
                print("존재")
                self.keyChains.delete("accessToken")
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        nicknameSettingView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    @objc func nextButtonTapped() {
        print("dddddd")
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
                self.nicknameSettingView.nextButton.snp.remakeConstraints {
                    $0.bottom.equalToSuperview().offset(height)
                    $0.height.equalTo(48)
                    $0.leading.trailing.equalToSuperview().inset(20)
                }
                self.view.layoutIfNeeded()
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseInOut, animations: {
                self.nicknameSettingView.nextButton.snp.remakeConstraints {
                    $0.height.equalTo(48)
                    $0.leading.trailing.equalToSuperview().inset(20)
                    $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
                }
                self.view.layoutIfNeeded()
            })
        }
    }
}

// MARK: - UITextField Delegate
extension NicknameSettingViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.nicknameSettingView.nickNameTextField.sdsTextfield.layer.borderColor = UIColor.lightBlue500.cgColor
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nicknameSettingView.nickNameTextField.sdsTextfield.resignFirstResponder()
        keyboardState(up: false)
        return true
    }

    @objc func textfieldDidChange(_ sender: Any) {
        guard let textFieldText = nicknameSettingView.nickNameTextField.sdsTextfield.text else {return}
        nicknameSettingView.nickNameTextField.textfieldCountLabel.text = "\(textFieldText.count)/10"
        if textFieldText.count >= 11 {
            nicknameSettingView.nickNameTextField.sdsTextfield.layer.borderColor = UIColor.red500.cgColor
            nicknameSettingView.nickNameTextField.errorLabel.isHidden = false
            nicknameSettingView.nickNameTextField.textfieldCountLabel.textColor = .red500

        } else {
            nicknameSettingView.nickNameTextField.sdsTextfield.layer.borderColor = UIColor.lightBlue500.cgColor
            nicknameSettingView.nickNameTextField.errorLabel.isHidden = true
            nicknameSettingView.nickNameTextField.textfieldCountLabel.textColor = .gray400
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        nicknameSettingView.nickNameTextField.textfieldCountLabel.text = "\(updatedText.count)/10"
        textCount = updatedText.count
        return true
    }
}

extension NicknameSettingViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return false
    }
}
