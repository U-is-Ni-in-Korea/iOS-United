//
//  EditProfileViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/15.
//

import UIKit

class EditProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    public var editProfileView = EditProfileView()
        
    private let userRepository = UserRepository()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editProfileNaviActions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileViewActions()
        anniversaryButtonActions()
        setTextViewConfig()
        editProfileView.changeProfileImageButton.isHidden = true
        
//        let tokenUtil = HeaderUtils()
//        tokenUtil.create(account: "accessToken", value: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhY2Nlc3NUb2tlbiIsImlhdCI6MTY4OTQ0ODMxNiwiZXhwIjoxNjkxMjQ4MzE2LCJ1c2VySWQiOjR9.uZk-_LWrpUgeFCqSKQ8alf8qQy23dVj22kH1dUHovMe9plvifv7lIsh8nn3honqb")
        
}
    
    override func loadView() {
        super.loadView()
        self.view = editProfileView
        
        anniversaryButtonActions()
    }

    func dataBind(userName: String, startDate: String) {
        editProfileView.nicknameTextfield.sdsTextfield.text = userName
        editProfileView.nicknameTextfield.textfieldCountLabel.text = "\(userName.count)/10"
        editProfileView.anniversaryDateLabel.text = startDate.stringToDate(toformat: "yyyy-MM-dd",fromFormat: "yyyy년 MM월 dd일")
    }
    
    func setTextViewConfig() {
        self.editProfileView.nicknameTextfield.letters = 15
        self.editProfileView.nicknameTextfield.sdsTextfield.delegate = self
        self.editProfileView.nicknameTextfield.sdsTextfield.addTarget(self,
                                                                      action: #selector(textFieldDidChange(_:)),
                                                                      for: .allEvents)
    }

    func editProfileNaviActions() {
        self.editProfileView.editProfileViewNavi.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)
        }
        
        
        self.editProfileView.editProfileViewNavi.rightBarSingleButtonLabelCompletionHandler = {
            [weak self] in
            guard let strongSelf = self else {return}
            guard let nickname = strongSelf.editProfileView.nicknameTextfield.sdsTextfield.text else {
                return
            }
            if nickname.count == 0 {
                strongSelf.editProfileView.nicknameTextfield.errorLabel.isHidden = false
                strongSelf.editProfileView.nicknameTextfield.errorLabel.text = "닉네임을 입력해주세요"
                strongSelf.editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
                strongSelf.editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.red500.cgColor
            } else if nickname.count  > 10 {
                strongSelf.editProfileView.nicknameTextfield.errorLabel.text = "글자수를 초과했어요"
                strongSelf.editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
                strongSelf.editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.red500.cgColor

            } else {
                strongSelf.view.showIndicator()
                let nickname = strongSelf.editProfileView.nicknameTextfield.sdsTextfield.text
                let anniversaryDate = strongSelf.editProfileView.anniversaryDateLabel.text
                if let nickname = nickname, let anniversaryDate = anniversaryDate {
                    if let startDate = strongSelf.convertDateString(anniversaryDate) {
                        print("기념일 형식 변경 완료")
                        
                        strongSelf.userRepository.patchUserProfile(nickname: nickname,
                                                                   startDate: startDate) {
                            response in
                            if response {
                                print("닉네임, 기념일 저장")
                                print (nickname)
                                print(startDate)
                                strongSelf.view.removeIndicator()
                            } else {
                                print("닉네임, 기념일 저장 실패")
                                strongSelf.view.removeIndicator()
                            }
                        }
                    
                strongSelf.navigationController?.popViewController(animated: true)
                    }
                }
            }
            }
    }
    
    func anniversaryButtonActions() {
        editProfileView.anniversaryButton.addTarget(self, action: #selector(anniversaryButtonTapped), for: .touchUpInside)
    }
    
    func editProfileViewActions() {
                
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImageTapped(_:)))
        editProfileView.changeProfileImageButton.addGestureRecognizer(tapGesture)
        editProfileView.isUserInteractionEnabled = true
        
    }
    
    @objc func changeProfileImageTapped(_ gesture: UITapGestureRecognizer) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        editProfileView.profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        editProfileView.profileImageView.backgroundColor = UIColor.clear
        editProfileView.profileImageView.contentMode = UIView.ContentMode.scaleToFill
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func anniversaryButtonTapped() {
        let datePickerViewController = DatePickerViewController()
        datePickerViewController.modalPresentationStyle = .overFullScreen
        datePickerViewController.modalTransitionStyle = .crossDissolve
        
        datePickerViewController.dateCompletionHandler = { [weak self] value in
            guard let self else { return }
            
            editProfileView.anniversaryDateLabel.text = value
            print("데이트피커값은왔어")
            print(value)
        }
        
        self.present(datePickerViewController, animated: true, completion: nil)

    }
    
    func convertDateString(_ dateString: String) -> String? {
        let inputDateFormat = "yyyy년 MM월 dd일"
        let outputDateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outputDateFormat
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
}

extension EditProfileViewController: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ sender: Any) {
        guard let nickname = editProfileView.nicknameTextfield.sdsTextfield.text else {
            return
        }
        //닉네임 수를 최대 15자까지 입력 가능
        if nickname.count > 10 {
            if nickname.count > 15 {
                editProfileView.nicknameTextfield.sdsTextfield.deleteBackward()
            }
            editProfileView.nicknameTextfield.errorLabel.isHidden = false
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.red500.cgColor
            editProfileView.nicknameTextfield.textfieldCountLabel.textColor = .red500
        } else {
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.lightBlue500.cgColor
            editProfileView.nicknameTextfield.textfieldCountLabel.textColor = .gray400
            editProfileView.nicknameTextfield.errorLabel.isHidden = true
        }
        
        editProfileView.nicknameTextfield.textfieldCountLabel.text = "\(editProfileView.nicknameTextfield.sdsTextfield.text?.count ?? 0)/10"
    }
}

