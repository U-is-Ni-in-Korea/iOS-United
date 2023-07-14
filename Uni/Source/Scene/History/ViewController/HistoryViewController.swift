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
//        setLayout()
//        setConfig()
//        setStyle()

    }
    
    override func loadView() {
            super.loadView()
            
            historyView = HistoryView(frame: self.view.frame)
            self.view = historyView
        }
    
    // MARK: - Setting
    private func setStyle() {
        
    }
    
    override func setLayout() {

    }
    
    override func setConfig() {
        
    }
    
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}
