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

        if let myState = historyData.myMission.result {
            if myState == "WIN" {
                historyDetailView.historyDetailResultMissionView.myHistoryResultView.bindChipText(title: historyDetailData?.myMission.time, subTitle: "미션 성공", status: .win)
            } else if myState == "LOSE"{
                historyDetailView.historyDetailResultMissionView.myHistoryResultView.bindChipText(subTitle: "미션 실패", status: .lose)
            }
            else {
                historyDetailView.historyDetailResultMissionView.myHistoryResultView.bindChipText(subTitle: "무승부", status: .draw)
            }
        }
        
        if let partnerState = historyData.partnerMission.result {
            if partnerState == "WIN" {
                historyDetailView.historyDetailResultMissionView.yourHistoryResultView.bindChipText(title:  historyDetailData?.partnerMission.time, subTitle: "미션 성공", status: .win)
            } else if partnerState == "LOSE"{
                historyDetailView.historyDetailResultMissionView.yourHistoryResultView.bindChipText(subTitle: "미션 실패", status: .lose)
            }
            else {
                historyDetailView.historyDetailResultMissionView.yourHistoryResultView.bindChipText(subTitle: "무승부", status: .draw)
            }
        }
        
        historyDetailView.historyDetailResultView.gameDateLabel.text = historyDetailData?.date ?? ""
        historyDetailView.historyDetailResultView.gameNameLabel.text = historyDetailData?.title ?? ""
        historyDetailView.historyDetailResultView.gameResultLabel.text = "\(historyDetailData?.winner ?? "")님이 이겼어요"
        historyDetailView.historyDetailResultMissionView.myHistoryResultView.missionTitleLabel.text = historyDetailData?.myMission.content
//        historyDetailView.historyDetailResultMissionView.myHistoryResultView.chipView.titleLabel.text = historyDetailData?.myMission.time
//        historyDetailView.historyDetailResultMissionView.myHistoryResultView.chipView.subTitleLabel.text = HistoryStatus(rawValue: historyDetailData?.myMission.result ?? "")?.getStatus()
//
        historyDetailView.historyDetailResultMissionView.yourHistoryResultView.missionTitleLabel.text = historyDetailData?.partnerMission.content
//        historyDetailView.historyDetailResultMissionView.yourHistoryResultView.chipView.titleLabel.text = historyDetailData?.partnerMission.time
//        historyDetailView.historyDetailResultMissionView.yourHistoryResultView.chipView.subTitleLabel.text = HistoryStatus(rawValue: historyDetailData?.partnerMission.result ?? "")?.getStatus()
        //1. 미션 성공/실패 여부 확인
        //2. 성공은 타이틀, 서브타이틀 둘다 있어야 하고
        //2. 실패는 타이틀만 있으면 됨
//        historyDetailView.historyDetailResultMissionView.yourHistoryResultView.bindChipText(title: historyDetailData?.partnerMission.time,
//                                                                                            subTitle: HistoryStatus(rawValue: historyDetailData?.partnerMission.result ?? "")?.getStatus(),
//                                                                                            status: state)
        
    }
    
}
