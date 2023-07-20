//
//  HistroyDetailViewController.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/15.
//

import UIKit
import Then
import SDSKit

class HistoryDetailViewController: BaseViewController, HistoryDetailViewDelegate {

    // MARK: - Property
    
    private var historyDetailView = HistoryDetailView()
    
    // MARK: - UI Property
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonTapped()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        
        historyDetailView = HistoryDetailView(frame: self.view.frame)
        historyDetailView.delegate = self
        self.view = historyDetailView
    }
    
    // MARK: - Setting
    
    private func setStyle() {
    }
    
    override func setLayout() {
    }
    
    override func setConfig() {
    }
    
    // MARK: - Action Helper
    
    func backButtonTapped() {
        self.historyDetailView.navigationBar.backButtonCompletionHandler = { [self] in self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Custom Method

}


