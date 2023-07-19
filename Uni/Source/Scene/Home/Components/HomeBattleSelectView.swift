import Foundation
import UIKit
import SDSKit
import Then
import SnapKit

final class HomeBattleSelectView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init(title: String,
         image: UIImage) {
        super.init(frame: .zero)
        self.setLayout()
        self.addHoverEffect()
        self.titleLabel.text = title
        self.imageView.image = image
    }
    
    func setProgress(progressInfo: String) {
        self.progressInfoLabel.text = progressInfo
    }
    
    private func setLayout() {
        self.backgroundColor = .gray000
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.addSubviews([titleLabel, progressInfoLabel, imageView])
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        progressInfoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(154)
            $0.height.equalTo(77)
        }
    }
    
    
    /**hovering effect**/
    var originColor: UIColor = .gray000
    func addHoverEffect() {
        let pressGesture = UILongPressGestureRecognizer(target: self, action: #selector(buttonLongPress(_:)))
        pressGesture.delegate = self
        pressGesture.minimumPressDuration = 0.0
        self.addGestureRecognizer(pressGesture)
    }
    
    @objc private func buttonLongPress(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            self.backgroundColor = originColor.blendColors(tintColor: .lightBlue50)
        default:
            self.backgroundColor = self.originColor
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.font = SDSFont.btn1.font
        $0.textColor = .gray600
    }
    private let progressInfoLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textColor = .gray350
    }
    private let imageView = UIImageView().then {
        $0.backgroundColor = .gray100
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
}
extension HomeBattleSelectView: UIGestureRecognizerDelegate {}
