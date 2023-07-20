//
//  HistoryView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/14.
//

import UIKit
import Then
import SnapKit
import SDSKit

final class HistoryView: UIView {
    
    // MARK: - Property
    
//    var count = 0 {
//        didSet {
//            if count > 0 {
//                hasHistoryData(hasData: true)
//            }
//            else {
//                hasHistoryData(hasData: false)
//            }
//        }
//    }


    // MARK: - UI Property
    
    private var historyEmptyView = HistoryEmptyView()
    
    let navigationBar = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "승부 히스토리") // 폰트 변경
    
    let historyTableView = UITableView().then {
        $0.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        $0.rowHeight = 103 // 셀의 높이
        $0.separatorStyle = .none // 셀의 구분선 없애기
    }
    
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
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            self.count = 5
//        }) // 2초 뒤에 count가 2로 변하면서 앞의 didSet 작동하면서 hasHistoryData(hasData: true)함수 실행
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        self.backgroundColor = .gray100
        self.historyTableView.isHidden = true
        historyTableView.backgroundColor = .gray100
    }
    
    private func setLayout() {
        [navigationBar, historyTableView, historyEmptyView]
            .forEach { addSubview($0) }
        
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        historyTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        historyEmptyView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method

    func hasHistoryData(hasData: Bool) {
        if hasData {
            DispatchQueue.main.async {
                self.historyEmptyView.isHidden = true
                self.historyTableView.isHidden = false
            }
        }
        else {
            DispatchQueue.main.async {
                self.historyEmptyView.isHidden = false
                self.historyTableView.isHidden = true
            }
        }
    }
}

