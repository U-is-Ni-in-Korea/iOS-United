//
//  HistoryDetailView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/15.
//

import UIKit
import Then
import SDSKit

final class HistoryDetailView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    let navigationBar = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "승부 히스토리") // 폰트 변경
    
    private var  historyDetailResultView = HistoryDetailResultView()
    
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
//        navigationBar.backButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24) // 네비바 백버튼 크기 조정
    }
    
    private func setLayout() {
        [navigationBar, historyDetailResultView]
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

    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}
