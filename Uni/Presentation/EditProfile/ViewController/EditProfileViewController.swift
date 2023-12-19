import UIKit

final class EditProfileViewController: BaseViewController {
    // MARK: - Property
    private let userRepository = UserRepository()
    // MARK: - UI Property
    private var editProfileView = EditProfileView()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = editProfileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        anniversaryButtonActions()
        setTextViewConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editProfileNaviActions()
        anniversaryButtonActions()
    }
    // MARK: - Setting
    func dataBind(userName: String, startDate: String) {
        editProfileView.nicknameTextfield.sdsTextfield.text = userName
        editProfileView.nicknameTextfield.textfieldCountLabel.text = "\(userName.count)/5"
        editProfileView.anniversaryDateLabel.text = startDate.stringToDate(toformat: "yyyy-MM-dd", fromFormat: "yyyy년 MM월 dd일")
    }
    func setTextViewConfig() {
        self.editProfileView.nicknameTextfield.sdsTextfield.delegate = self
        self.editProfileView.nicknameTextfield.sdsTextfield.addTarget(self,
                                                                      action: #selector(textFieldDidChange(_:)),
                                                                      for: .allEvents)
    }
    // MARK: - Action Helper
    func anniversaryButtonActions() {
        editProfileView.anniversaryButton.addTarget(self, action: #selector(anniversaryButtonTapped), for: .touchUpInside)
    }
    // MARK: - @objc Methods
    @objc func anniversaryButtonTapped() {
        let datePickerViewController = DatePickerViewController()
        datePickerViewController.modalPresentationStyle = .overFullScreen
        datePickerViewController.modalTransitionStyle = .crossDissolve
        datePickerViewController.dateCompletionHandler = { [weak self] value in
            guard let self else { return }
            editProfileView.anniversaryDateLabel.text = value
        }
        self.present(datePickerViewController, animated: true, completion: nil)
    }
    // MARK: - Custom Method
    func saveButtonStatus(enable: Bool) {
        self.editProfileView.editProfileViewNavi.rightBarSingleButtonItem.isEnabled = enable
        self.editProfileView.editProfileViewNavi.rightBarSingleButtonLabel.textColor = enable ? .lightBlue600 : .gray400
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

extension EditProfileViewController: UINavigationControllerDelegate {

    func editProfileNaviActions() {
        self.editProfileView.editProfileViewNavi.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)
        }
        self.editProfileView.editProfileViewNavi.rightBarSingleButtonLabelCompletionHandler = { [weak self] in
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
                        strongSelf.userRepository.patchUserProfile(nickname: nickname,
                                                                   startDate: startDate) { response in
                            if response {
                                print(nickname)
                                print(startDate)
                                strongSelf.view.removeIndicator()
                                strongSelf.navigationController?.popViewController(animated: true)
                            } else {
                                strongSelf.view.removeIndicator()
                            }
                        }
                    }
                }
            }
        }
    }

}
// MARK: - Extensions
extension EditProfileViewController: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ sender: Any) {
        guard let nickname = editProfileView.nicknameTextfield.sdsTextfield.text else {
            return
        }
        if nickname.count == 0 {
            editProfileView.nicknameTextfield.errorLabel.isHidden = false
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.red500.cgColor
            editProfileView.nicknameTextfield.textfieldCountLabel.textColor = .red500
            editProfileView.nicknameTextfield.errorLabel.text = "닉네임을 입력해주세요"
            saveButtonStatus(enable: false)
        }
        // 닉네임 수를 최대 10자까지 입력 가능
        else if nickname.count > 5 {
            if nickname.count > 10 {
                editProfileView.nicknameTextfield.sdsTextfield.deleteBackward()
            }
            editProfileView.nicknameTextfield.errorLabel.isHidden = false
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.red500.cgColor
            editProfileView.nicknameTextfield.textfieldCountLabel.textColor = .red500
            editProfileView.nicknameTextfield.errorLabel.text = "글자수를 초과했어요"
            saveButtonStatus(enable: false)
        } else if nickname.count <= 5 {
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderWidth = 1
            editProfileView.nicknameTextfield.sdsTextfield.layer.borderColor = UIColor.lightBlue500.cgColor
            editProfileView.nicknameTextfield.textfieldCountLabel.textColor = .gray400
            editProfileView.nicknameTextfield.errorLabel.isHidden = true
            saveButtonStatus(enable: true)
        }
        editProfileView.nicknameTextfield.textfieldCountLabel.text = "\(editProfileView.nicknameTextfield.sdsTextfield.text?.count ?? 0) / 5"
    }
}
