//
//  HistoryViewController.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/14.
//

import UIKit
import Then
import SDSKit

class HistoryViewController: BaseViewController {

    // MARK: - Property
    
    private var historyView = HistoryView()
    
    // MARK: - UI Property
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setLayout()
        setStyle()

    }
    
    override func loadView() {
        super.loadView()
        
        historyView = HistoryView(frame: self.view.frame)
        self.view = historyView
    }
    
    // MARK: - Setting
    
    private func setDelegate() {
        historyView.historyTableView.dataSource = self
        historyView.historyTableView.delegate = self
    }
    
    private func setStyle() {

    }
    
    override func setLayout() {

    }
    
    override func setConfig() {
        
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}


// MARK: - UITableView Delegate

extension HistoryViewController: UITableViewDelegate {
    
}


// MARK: - UITableView DataSource

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 // 뷰 컨에 보일 셀 수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none // 셀 눌렀을 때 클릭한 거 안 보이게
        cell.configureCell() // 셀에 내용을 붙여주는 함수를 불러온 것
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let historyDetailViewController = HistoryDetailViewController()
        navigationController?.pushViewController(historyDetailViewController, animated: true)
        
    }
}
