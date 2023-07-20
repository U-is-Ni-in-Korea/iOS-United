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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileNaviActions()
        editProfileViewActions()
        anniversaryButtonActions()
}
    
    override func loadView() {
        super.loadView()
        self.view = editProfileView
        
        anniversaryButtonActions()
    }

    func dataBind(userName: String, startDate: String) {
        editProfileView.nicknameTextfield.sdsTextfield.text = userName
        editProfileView.nicknameTextfield.textfieldCountLabel.text = "\(userName.count)/15"
        editProfileView.anniversaryDateLabel.text = startDate
    }
    
    func editProfileNaviActions() {
        
        self.editProfileView.editProfileViewNavi.backButtonCompletionHandler = { [self] in self.navigationController?.popViewController(animated: true)
        }
        
        editProfileView.editProfileViewNavi.rightBarSingleButtonLabelCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)
            //저장 구현
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
        self.present(datePickerViewController, animated: true, completion: nil)
        
        datePickerViewController.dateCompletionHandler = { [weak self] value in
            
            guard let self else { return }
            
            editProfileView.anniversaryDateLabel.text = value
        }
    }
    
}

extension EditProfileViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let nickname = editProfileView.nicknameTextfield.sdsTextfield.text else {
            return
        }
        if nickname.count > 15 {
            editProfileView.nicknameTextfield.sdsTextfield.deleteBackward()
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.red500.cgColor
        } else if 10 < nickname.count {
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.red500.cgColor
        }
        else {
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.lightBlue500.cgColor
        }
        
        if nickname.count == 0 || nickname.count > 10 {
            editProfileView.editProfileViewNavi.rightBarRightButtonItem.isEnabled = false
            print(editProfileView.editProfileViewNavi.rightBarRightButtonItem.isEnabled)
        } else {
            editProfileView.editProfileViewNavi.rightBarRightButtonItem.isEnabled = true
        }
    }
}
