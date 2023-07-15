import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

class BattleCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.contentView.layer.borderColor = UIColor.lightBlue500.cgColor
                self.contentView.layer.borderWidth = 1
            } else {
                self.contentView.layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bindText(iconImage: UIImage,
                  title: String) {
        self.iconImageView.image = iconImage
        self.titleLabel.text = title
    }
    
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
    
    private func updateCell() {
        self.contentView.layer.borderColor = UIColor.lightBlue500.cgColor
        self.contentView.layer.borderWidth = 1
    }
    
    private let iconImageView = UIImageView(image: SDSIcon.icAppleLogin)
    private let titleLabel = UILabel().then {
        $0.font = SDSFont.btn2.font
        $0.textColor = .gray600
    }
    private let arrowButton = UIButton().then {
        $0.tintColor = .gray250
        $0.setImage(SDSIcon.icChevron.withTintColor(.gray250, renderingMode: .alwaysTemplate), for: .normal)
    }
    
}
