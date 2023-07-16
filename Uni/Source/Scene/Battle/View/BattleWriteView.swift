import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

private class BattleWriteView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
    }
    
    let navigationBar = BattleNavigationBar()
    
    //myMissionInfoView
    let myMissionSectionTitle = UILabel().then {
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    let myMissionInfoView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .gray000
    }
    let myMissionInfoIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    let myMissionTitleLabel = UILabel().then {
        $0.font = SDSFont.btn2.font
        $0.textColor = .gray600
    }
    let myMissionSummaryLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textColor = .gray600
    }
    let arrowIconImageView = UIImageView(image: SDSIcon.icChevron.resize(targetSize: .init(width: 24, height: 24)).withTintColor(.gray250, renderingMode: .alwaysTemplate))
    
    //otherMission
    
}
