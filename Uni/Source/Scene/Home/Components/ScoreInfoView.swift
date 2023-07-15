import Foundation
import UIKit
import SDSKit
import Then
import SnapKit

final class ScoreInfoView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init(separatorLeft: Bool,
         separatorRight: Bool) {
        super.init(frame: .zero)
        self.setLayout()
        if separatorLeft {
            self.separatorView1.isHidden = false
        }
        if separatorRight {
            self.separatorView2.isHidden = false
        }
    }
    
    func bindData(count: Int,
                  countLabelColor: UIColor,
                  info: String,
                  infoLabelColor: UIColor) {
        self.countLabel.text = "\(count)"
        self.countLabel.textColor = countLabelColor
        self.countInfoLabel.text = info
        self.countInfoLabel.textColor = infoLabelColor
    }
    
    private func setLayout() {
        self.addSubviews([countLabel, countInfoLabel, separatorView1, separatorView2])
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(38)
        }
        countInfoLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        separatorView1.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(7)
            $0.width.equalTo(1)
        }
        separatorView1.isHidden = true
        separatorView2.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(7)
            $0.width.equalTo(1)
        }
        separatorView2.isHidden = true
    }
    
    private let countLabel = UILabel().then {
        $0.font = SDSFont.headLine.font
        $0.textAlignment = .center
    }
    private let countInfoLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textAlignment = .center
    }
    private let separatorView1 = UIView().then {
        $0.backgroundColor = .gray200
    }
    private let separatorView2 = UIView().then {
        $0.backgroundColor = .gray200
    }
}
