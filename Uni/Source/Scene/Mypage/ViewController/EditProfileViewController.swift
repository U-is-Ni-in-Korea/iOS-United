//
//  EditProfileViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/15.
//

import UIKit

class EditProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var editProfileView = EditProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileViewActions()
    }
    
    override func loadView() {
        super.loadView()
        
        editProfileView = EditProfileView(frame: self.view.frame)
        self.view = editProfileView
        
    }
    
    func editProfileViewActions() {
        
        self.editProfileView.editProfileViewNavi.backButtonCompletionHandler = { [self] in self.navigationController?.popViewController(animated: true)
        }
        
        editProfileView.anniversaryButton.addTarget(self, action: #selector(anniversaryButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImageTapped(_:)))
        editProfileView.changeProfileImageButton.addGestureRecognizer(tapGesture)
        editProfileView.isUserInteractionEnabled = true
    }
    
    @objc
        func changeProfileImageTapped(_ gesture: UITapGestureRecognizer) {
            print("ProfileTap")
            
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
    
    @objc
    func anniversaryButtonTapped() {
        let datePickerViewController = DatePickerViewController()
        datePickerViewController.modalPresentationStyle = .overFullScreen
        datePickerViewController.modalTransitionStyle = .crossDissolve
        self.present(datePickerViewController, animated: true, completion: nil)
        print("tapped")
        
        datePickerViewController.dateCompletionHandler = { [weak self] value in
            
            guard let self else { return }
            
            editProfileView.anniversaryDateLabel.text = value
        }
    }
}
