import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

class BattleNavigationBar: UIView {
    var dismissButtonTapCompletion: (() -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
    }
    
    func bindText(title: String) {
        self.titleLabel.text = title
    }
    
    private func setLayout() {
        self.addSubviews([titleLabel, dismissButton])
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        dismissButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(36)
        }
    }
    
    @objc private func didButtonTapped() {
        guard let completion = self.dismissButtonTapCompletion else {return}
        completion()
    }
    
    private let titleLabel = UILabel().then {
        $0.font = SDSFont.title1.font
        $0.textColor = .gray600
    }
    
    private lazy var dismissButton = UIButton().then {
        $0.tintColor = .gray600
        $0.addTarget(self,
                     action: #selector(didButtonTapped),
                     for: .touchUpInside)
        $0.setImage(SDSIcon.icDismiss.resize(targetSize: .init(width: 36, height: 36)).withTintColor(.gray600, renderingMode: .alwaysTemplate), for: .normal)
    }
}
