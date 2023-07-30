import UIKit

final class BattleHistoryViewController: BaseViewController {

    override func loadView() {
        super.loadView()
        self.view = battleHistoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addButtonGesture()
        self.getRoundMissionId()
        self.addNavigationButtonAction()
    }
    
    //MARK: - Network
    private func getRoundMissionData(roundId: Int) {
        self.view.showIndicator()
        battleRepository.getRoundGameData(roundId: roundId) { [weak self] data in
            guard let strongSelf = self else {return}
            strongSelf.battleData = data
            strongSelf.battleHistoryView.bindData(myMission: data.myRoundMission)
            strongSelf.view.removeIndicator()
        }
    }
    
    private func getRoundMissionId() {
        self.view.showIndicator()
        homeRepository.getHomeData { [weak self] data in
            guard let strongSelf = self else {return}
            if let roundId = data.roundGameId {
                strongSelf.roundId = roundId
                strongSelf.getRoundMissionData(roundId: roundId)
                strongSelf.view.removeIndicator()
            }
        }
    }
    
    //MARK: - controll
    private func addNavigationButtonAction() {
        self.battleHistoryView.navigationBar.dismissButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
        }
    }
    
    private func addButtonGesture() {
        let completeGesture = UITapGestureRecognizer(target: self,
                                                     action: #selector(completeButtonTap))
        completeGesture.delegate = self
        self.battleHistoryView.missionCompleteButton.addGestureRecognizer(completeGesture)
        
        let failGesture = UITapGestureRecognizer(target: self,
                                                     action: #selector(failButtonTap))
        failGesture.delegate = self
        self.battleHistoryView.missionFailButton.addGestureRecognizer(failGesture)
        
        let infoGesture = UITapGestureRecognizer(target: self,
                                                 action: #selector(showInfoButtonTap))
        self.battleHistoryView.myMissionInfoView.addGestureRecognizer(infoGesture)
        
        let quitBattleGesture = UITapGestureRecognizer(target: self,
                                                       action: #selector(quitBattleButtonTap))
        self.battleHistoryView.quitButton.addGestureRecognizer(quitBattleGesture)
    }
    
    @objc private func completeButtonTap() {
        self.view.showIndicator()
        self.battleRepository.patchRoundGameData(state: true,
                                                 roundId: self.roundId) { [weak self] data in
            guard let strongSelf = self else {return}
            //미션 성공
            //게임 히스토리로 이동
            strongSelf.view.removeIndicator()
            let resultVC = BattleResultViewController()
            
            resultVC.modalPresentationStyle = .overFullScreen
            guard let pvc = strongSelf.presentingViewController else { return }
            strongSelf.dismiss(animated: true) {
                resultVC.bindRoundID(roundID: strongSelf.roundId)
              pvc.present(resultVC, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func failButtonTap() {
        self.view.showIndicator()
        self.battleRepository.patchRoundGameData(state: false,
                                                 roundId: self.roundId) { [weak self] data in
            guard let strongSelf = self else {return}
            //미션 실패
            //게임 히스토리로 이동
            strongSelf.view.removeIndicator()
            let resultVC = BattleResultViewController()
            
            resultVC.modalPresentationStyle = .overFullScreen
            guard let pvc = strongSelf.presentingViewController else { return }
            strongSelf.dismiss(animated: true) {
                resultVC.bindRoundID(roundID: strongSelf.roundId)
              pvc.present(resultVC, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func showInfoButtonTap() {
        let descriptionVC = BattleCategoryViewController()
        descriptionVC.modalPresentationStyle = .overFullScreen
        if let data = self.battleData {
            descriptionVC.missionId = data.myRoundMission.missionContent.missionCategory.id
        }
        self.present(descriptionVC, animated: true)
    }
    
    @objc private func quitBattleButtonTap() {
        let alert = self.view.showAlert(title: "승부를 이대로 중단하시나요?",
                                        message: "소모된 하트는 다시 돌아오지 않아요",
                                        cancelButtonMessage: "취소",
                                        okButtonMessage: "확인",
                                        type: .alert)
        alert.okButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.view.showIndicator()
            strongSelf.battleRepository.deleteRoundGameData(roundId: strongSelf.roundId) { [weak self] data in
                guard let strongSelf = self else {return}
                strongSelf.view.removeIndicator()
                strongSelf.dismiss(animated: true)
            }
        }
        alert.cancelButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.view.hideAlert(view: alert)
        }
    }
    
    private var battleHistoryView = BattleHistoryView()
    private var battleRepository = BattleRepository()
    private var homeRepository = HomeRepository()
    private var battleData: RoundBattleDataModel?
    private var roundId: Int = 0
}
extension BattleHistoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
