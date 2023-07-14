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
    
    
    
    // MARK: - UI Property
    
    let navigationBar = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "승부 히스토리") // 폰트 변경
    
    let historyTableView = UITableView().then {
        $0.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        $0.rowHeight = 101 // 셀의 높이
        $0.separatorStyle = .none // 셀의 구분선 없애기
    }
    
    
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setStyle()
        setDelegate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setStyle()
        setDelegate()
    }
    
    // MARK: - Setting
    
    private func setDelegate() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }
    
    private func setStyle() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        [navigationBar, historyTableView]
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
    }
    
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}


// MARK: - UITableView Delegate

extension HistoryView: UITableViewDelegate {

}


// MARK: - UITableView DataSource

extension HistoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // 뷰 컨에 보일 셀 수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configureCell() // 셀에 내용을 붙여주는 함수를 불러온 것
        return cell
    }
}
