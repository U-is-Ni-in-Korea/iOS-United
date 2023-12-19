import Foundation
import UIKit
import SDSKit
import SnapKit
import Then
import Kingfisher

class BattleCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    var buttonTapCompletion: (() -> Void)?
    // MARK: - UI Property
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    private let titleLabel = UILabel().then {
        $0.font = SDSFont.btn2.font
        $0.textColor = .gray600
    }
    private lazy var arrowButton = UIButton().then {
        $0.tintColor = .gray250
        $0.setImage(SDSIcon.icChevron.withTintColor(.gray250, renderingMode: .alwaysTemplate), for: .normal)
    }
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didCellTap))
        self.contentView.addGestureRecognizer(tapGesture)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: - Setting
    private func setLayout() {
        self.contentView.addSubviews([iconImageView, titleLabel, arrowButton])
        iconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(12)
            $0.width.height.equalTo(32)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.leading)
            $0.top.equalTo(iconImageView.snp.bottom).offset(2)
        }
        arrowButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
            $0.width.height.equalTo(24)
        }
        self.contentView.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = .gray000
    }
    func bindText(iconImage: String,
                  title: String) {
        if let url = URL(string: iconImage) {
            self.iconImageView.kf.setImage(with: url)
        }
        self.titleLabel.text = title
    }
    // MARK: - @objc Methods
    @objc private func didArrowButtonTap() {
        guard let completion = buttonTapCompletion else {return}
        completion()
    }
    @objc private func didCellTap() {
        guard let completion = buttonTapCompletion else {return}
        completion()
    }
}
