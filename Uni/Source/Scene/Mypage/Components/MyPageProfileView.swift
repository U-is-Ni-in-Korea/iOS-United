//
//  MyPageProfileView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

final class MyPageProfileView: UIView {

    lazy var userImageView = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.image = UIImage(named: "logo") // 임시
    }

    lazy var userNameLabel = UILabel().then {
        $0.font = SDSFont.title2.font
        $0.textColor = .gray600
    }

    lazy var editProfileButton = UIButton().then {
        $0.setImage(UIImage(named: "pencil"), for: .normal)
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

extension MyPageProfileView {

    private func setStyle() {
        self.backgroundColor = .gray000
    }

    private func setLayout() {
        [userImageView, userNameLabel, editProfileButton] .forEach { addSubview($0)}

        userImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(23)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(76)
        }

        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(34)
            $0.centerY.equalToSuperview()
        }

        editProfileButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }

}
