import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

final class CategoryDescriptionView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
    }
    
    func bindText(description: String) {
        self.descriptionLabel.text = description
    }
    
    private func setLayout() {
        self.addSubview(descriptionLabel)
        self.backgroundColor = .gray000
        self.layer.cornerRadius = 10
        
        descriptionLabel.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(20)
//            $0.bottom.greaterThanOrEqualToSuperview().inset(20)
        }
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = SDSFont.body2Long.font
        $0.textColor = .gray600
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
}
