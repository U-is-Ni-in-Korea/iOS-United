//
//  EditProfileView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/15.
//

import UIKit
import SDSKit
import Then

final class EditProfileView: UIView {

    let editProfileViewNavi = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "프로필 수정").then {
        $0.rightBarSingleButtonLabel.text = "저장"
    }

    lazy var profileImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.layer.borderWidth = 1
        $0.image = UIImage(named: "logo")
    }

    var changeProfileImageButton = SDSChips(type: .blue, title: "사진 변경하기")

    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }

    public lazy var nicknameTextfield = SDSTextfield(placeholder: "", errorMessage: "글자수를 초과했어요", letterLimit: 10).then {
        $0.sdsTextfield.layer.borderColor = UIColor.lightBlue500.cgColor
    }

    private let anniversaryLabel = UILabel().then {
        $0.text = "커플 기념일"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }

    var anniversaryButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightBlue500.cgColor
        $0.backgroundColor = .gray000
    }

    public lazy var anniversaryDateLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.font = SDSFont.body2.font
        $0.textColor = .gray600
        $0.textAlignment = .left
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = 8
        profileImageView.clipsToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension EditProfileView {

    private func setStyle() {
        self.backgroundColor = .gray000
    }

    private func setLayout() {
        addSubviews([editProfileViewNavi, profileImageView, changeProfileImageButton, nicknameLabel, nicknameTextfield, anniversaryLabel, anniversaryButton])
        anniversaryButton.addSubview(anniversaryDateLabel)

        editProfileViewNavi.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        profileImageView.snp.makeConstraints {
            $0.top.equalTo(editProfileViewNavi.snp.bottom).offset(38)
            $0.width.height.equalTo(76)
            $0.centerX.equalToSuperview()
        }

        changeProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(27)
            $0.centerX.equalToSuperview()
        }

        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(changeProfileImageButton.snp.bottom).offset(29)
            $0.leading.equalToSuperview().inset(20)
        }

        nicknameTextfield.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        anniversaryLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextfield.snp.bottom).offset(17)
            $0.leading.equalToSuperview().inset(20)
        }

        anniversaryButton.snp.makeConstraints {
            $0.top.equalTo(anniversaryLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }

        anniversaryDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }

}
