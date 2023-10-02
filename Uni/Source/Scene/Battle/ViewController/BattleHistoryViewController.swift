import Combine
import UIKit
import SwiftUI

final class BattleHistoryViewController: BaseViewController {
    // MARK: - Property
    private var cancellables: [AnyCancellable] = []
    private var roundId: Int = 0
    private let battleHistoryViewData = BattleHistoryViewData()
    private var battleRepository = BattleRepository()
    private var homeRepository = HomeRepository()
    private var battleData: RoundBattleDataModel?
    // MARK: - UI Property
    private var battleHistoryHostingController: UIHostingController<BattleHistoryView>!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getRoundMissionId()
        addNavigationButtonAction()
        setConfig()
        setLayout()
        addNavigationButtonAction()
        addMissionCompleteButtonAction()
    }
    // MARK: - Setting
    override func setConfig() {
        battleHistoryHostingController = UIHostingController(rootView: BattleHistoryView(data: battleHistoryViewData))
        self.addChild(battleHistoryHostingController)
        view.addSubview(battleHistoryHostingController.view)
        battleHistoryHostingController.didMove(toParent: self)
    }
    override func setLayout() {
        battleHistoryHostingController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    // MARK: - Action Helper
    private func addNavigationButtonAction() {
        battleHistoryViewData.dismissButtonTapPublisher.sink { [weak self] _ in
            self?.dismiss(animated: true)
        }
        .store(in: &cancellables)
    }
    private func addMissionCompleteButtonAction() {
        battleHistoryViewData.missionCompleteButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.view.showIndicator()
            self.battleRepository.patchRoundGameData(state: true,
                                                     roundId: self.roundId) { [weak self] _ in
                guard let self = self else {return}
                // 미션 성공
                // 게임 히스토리로 이동
                self.view.removeIndicator()
                let resultVC = BattleResultViewController()
                resultVC.roundId = self.roundId
                resultVC.modalPresentationStyle = .overFullScreen
                guard let pvc = self.presentingViewController else { return }
                self.dismiss(animated: true) {
                  pvc.present(resultVC, animated: true, completion: nil)
                }
            }
        }
        .store(in: &cancellables)
    }
    private func missionFailureButtonAction() {
        battleHistoryViewData.missionFailureButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.view.showIndicator()
            self.battleRepository.patchRoundGameData(state: false,
                                                     roundId: self.roundId) { [weak self] _ in
                guard let strongSelf = self else {return}
                // 미션 실패
                // 게임 히스토리로 이동
                strongSelf.view.removeIndicator()
                let resultVC = BattleResultViewController()
                resultVC.roundId = strongSelf.roundId
                resultVC.modalPresentationStyle = .overFullScreen
                guard let pvc = strongSelf.presentingViewController else { return }
                strongSelf.dismiss(animated: true) {
                  pvc.present(resultVC, animated: true, completion: nil)
                }
            }
        }.store(in: &cancellables)
    }
    // MARK: - Custom Method
    private func getRoundMissionData(roundId: Int) {
        battleRepository.getRoundGameData(roundId: roundId) { [weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.battleHistoryViewData.rountBattle = data
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
}
