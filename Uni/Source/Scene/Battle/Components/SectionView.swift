import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

final class SectionView: UICollectionReusableView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    func bindText(title: String,
                  subTitle: String? = nil) {
        self.titleLabel.text = title
        
        if subTitle == nil {
            subTitleLabel.isHidden = true
        } else {
            subTitleLabel.isHidden = false
            if let subTitle = subTitle {
                subTitleLabel.text = subTitle
            }
        }
    }
    
    private func setLayout() {
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(16)
        }
        stackView.addArrangeSubViews([titleLabel, subTitleLabel])
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 6
        $0.distribution = .equalSpacing
    }
    
    private let titleLabel = UILabel().then {
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textColor = .gray350
    }
}
