//
//  HistoryDetailView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/15.
//

import UIKit
import Then
import SDSKit

protocol HistoryDetailViewDelegate: AnyObject {
    func backButtonTapped()
}

final class HistoryDetailView: UIView {
    
    // MARK: - Property
    
    weak var delegate: HistoryDetailViewDelegate?
    
    // MARK: - UI Property
    
    let navigationBar = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "승부 히스토리")
    
    var historyDetailResultView = HistoryDetailResultView()
    
    var historyDetailResultMissionView = HistoryDetailResultMissionView()
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setStyle()
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        self.backgroundColor = .gray100
    }
    
    private func setLayout() {
        [navigationBar, historyDetailResultView, historyDetailResultMissionView]
            .forEach { addSubview($0) }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        historyDetailResultView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(133)
        }
        
        historyDetailResultMissionView.snp.makeConstraints {
            $0.top.equalTo(historyDetailResultView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(176)
        }

    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
    func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
}
