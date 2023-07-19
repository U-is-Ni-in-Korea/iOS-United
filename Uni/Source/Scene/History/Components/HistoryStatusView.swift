//
//  HistoryStatusView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/19.
//

import UIKit
import SDSKit
import Then

class HistoryStatusView: UIView {
    
    // MARK: - Property
    
    lazy var contentWidth: CGFloat = {
        return (UIScreen.main.bounds.width - 49 ) / 2
    }()
    
    lazy var contentHeight: CGFloat = {
        return self.contentWidth / 163 * 104
    }()
    
    // MARK: - UI Property
    
    private let sectionTitleLabel = UILabel().then {
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    
    private let backGroundContentView = UIView().then {
        $0.backgroundColor = .gray000
        $0.layer.cornerRadius = 10
    }
    
    //미션타이틀과 칩스의 스택뷰
    private let backGroundStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .leading
        $0.spacing = 18
    }
    
    //필요o
    private let missionTitleLabel = UILabel().then {
        $0.font = SDSFont.btn2.font
        $0.textColor = .gray600
    }
    
    //필요o
    private let chipView = HistoryChipView()
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
        
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        self.addSubviews([sectionTitleLabel, backGroundContentView])
        
        sectionTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        backGroundContentView.snp.makeConstraints {
            $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        backGroundContentView.addSubviews([backGroundStackView])
        
        backGroundStackView.snp.makeConstraints {
            $0.height.equalTo(contentHeight)
            $0.edges.equalToSuperview().inset(20)
        }
        
        backGroundStackView.addArrangeSubViews([missionTitleLabel, chipView])
        
        missionTitleLabel.snp.makeConstraints {
//            $0.top.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        chipView.snp.makeConstraints {
//            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(26)
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
    /**summary의 유무에 따라 chip 위치 변경**/
    func bindText(sectionTitle: String,
                  title: String,
                  status: HistoryStatus) {
        self.sectionTitleLabel.text = sectionTitle
        switch status {
        case .win, .lose, .draw:
            self.missionTitleLabel.text = title
            }
    }
    
    /**title유무에 따라, chip의 길이 변경, status로 색 변경**/
    func bindChipText(title: String? = nil,
                      subTitle: String,
                      status: HistoryStatus) {
        self.chipView.setTitle(title: title,
                               subTtile: subTitle)
        switch status {
        case .win:
            self.chipView.setConfig(titleColor: .green600,
                                    subTitleColor: .green600,
                                    backGroundColor: .green50)
        case .lose:
            self.chipView.setConfig(titleColor: .pink600,
                                    subTitleColor: .pink600,
                                    backGroundColor: .pink50)
        case .draw:
            self.chipView.isHidden = true
            break
        }
    }
}
