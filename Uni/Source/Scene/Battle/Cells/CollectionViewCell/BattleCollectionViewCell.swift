import Foundation
import UIKit
import SDSKit
import SnapKit
import Then
import Kingfisher

class BattleCollectionViewCell: UICollectionViewCell {
    var buttonTapCompletion: (() -> Void)?
    
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                self.contentView.layer.borderColor = UIColor.lightBlue500.cgColor
//                self.contentView.layer.borderWidth = 1
//            } else {
//                self.contentView.layer.borderWidth = 0
//            }
//        }
//    }
    
    func update(_ status:Bool?){
        if let status = status,
            status {
            self.contentView.layer.borderColor = UIColor.lightBlue500.cgColor
            self.contentView.layer.borderWidth = 1
        } else {
            self.contentView.layer.borderWidth = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bindText(iconImage: String,
                  title: String) {
        if let url = URL(string: iconImage) {
            self.iconImageView.kf.setImage(with: url)
        }
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
    
    @objc private func didArrowButtonTap() {
        guard let completion = buttonTapCompletion else {return}
        completion()
    }
    
    private func updateCell() {
        self.contentView.layer.borderColor = UIColor.lightBlue500.cgColor
        self.contentView.layer.borderWidth = 1
    }
    
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    private let titleLabel = UILabel().then {
        $0.font = SDSFont.btn2.font
        $0.textColor = .gray600
    }
    private lazy var arrowButton = UIButton().then {
        $0.addTarget(self,
                     action: #selector(didArrowButtonTap),
                     for: .touchUpInside)
        $0.tintColor = .gray250
        $0.setImage(SDSIcon.icChevron.withTintColor(.gray250, renderingMode: .alwaysTemplate), for: .normal)
    }
    
}
