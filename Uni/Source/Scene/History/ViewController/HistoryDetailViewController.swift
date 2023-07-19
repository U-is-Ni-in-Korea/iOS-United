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
    
    private var historyDetailData: HistoryDataModel?
    
    // MARK: - UI Property
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonTapped()

        guard let historyDetailData = historyDetailData else { return }
        dataBind(historyData: historyDetailData)
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
    
    func dataBind(historyData: HistoryDataModel) {
        print(historyData, "데이터")
        historyDetailData = historyData
        
        historyDetailView.historyDetailResultView.gameDateLabel.text = historyDetailData?.date ?? ""
        historyDetailView.historyDetailResultView.gameNameLabel.text = historyDetailData?.title ?? ""
        historyDetailView.historyDetailResultView.gameResultLabel.text = "\(historyDetailData?.winner ?? "")님이 이겼어요"
        historyDetailView.historyDetailResultMissionView.myHistoryResultView.missionTitleLabel.text = historyData.myMission.content
        historyDetailView.historyDetailResultMissionView.myHistoryResultView.chipView.titleLabel.text = historyData.myMission.time
        historyDetailView.historyDetailResultMissionView.myHistoryResultView.chipView.subTitleLabel.text = HistoryStatus(rawValue: historyDetailData?.myMission.result ?? "")?.getStatus()
        
        historyDetailView.historyDetailResultMissionView.yourHistoryResultView.missionTitleLabel.text = historyData.partnerMission.content
        historyDetailView.historyDetailResultMissionView.yourHistoryResultView.chipView.titleLabel.text = historyData.partnerMission.time
        historyDetailView.historyDetailResultMissionView.yourHistoryResultView.chipView.subTitleLabel.text = HistoryStatus(rawValue: historyDetailData?.partnerMission.result ?? "")?.getStatus()
//
//        historyDetailView.historyDetailResultMissionView.bindMyMissionData(missionTitle: historyData.myMission.content ?? "", clearAt: historyData.myMission.time ?? "", status: HistoryStatus(rawValue: historyData.myMission.result ?? "") ?? <#default value#>)
//
//        historyDetailView.historyDetailResultMissionView.bindYourMissionData(missionTitle: historyData.partnerMission.content ?? "", clearAt: historyData.partnerMission.time ?? "", status: HistoryStatus(rawValue: historyData.partnerMission.result ?? "") ?? <#default value#>)
        
    }
    
}
