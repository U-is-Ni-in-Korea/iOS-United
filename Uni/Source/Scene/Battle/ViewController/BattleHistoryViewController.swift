import Combine
import UIKit
import SwiftUI

final class BattleHistoryViewController: BaseViewController {
    // MARK: - Property
    let timerViewData: TimerData
    private var cancellables: [AnyCancellable] = []
    private var roundId: Int = 0
    private let battleHistoryViewData = BattleHistoryViewData()
    private var battleRepository = BattleRepository()
    private var homeRepository = HomeRepository()
    private var battleData: RoundBattleDataModel?
    // MARK: - UI Property
    private var battleHistoryHostingController: UIHostingController<BattleHistoryView>!
    // MARK: - Life Cycle
    init(timerViewData: TimerData) {
        self.timerViewData = timerViewData
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getRoundMissionId()
        addNavigationButtonAction()
        setConfig()
        setLayout()
        addNavigationButtonAction()
        addMissionCompleteButtonAction()
        addmissionFailureButtonAction()
        toolButtonAction()
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
    private func toolButtonAction() {
        battleHistoryViewData.memoButtonTapSubject.sink { [weak self] _ in
            let battleMemoViewController = BattleMemoViewController()
            self?.navigationController?.pushViewController(battleMemoViewController, animated: true)
        }
        .store(in: &cancellables)
        battleHistoryViewData.timerButtonTapSubejct.sink { [weak self] _ in
            guard let self = self else { return }
            let battleTimerViewController = BattleTimerViewController(timerViewData: timerViewData)
            self.navigationController?.pushViewController(battleTimerViewController, animated: true)

        }
        .store(in: &cancellables)
    }
    private func addMissionCompleteButtonAction() {
        battleHistoryViewData.missionCompleteButtonTapSubject.sink { [weak self] _ in
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
    private func addmissionFailureButtonAction() {
        battleHistoryViewData.missionFailureButtonTapSubject.sink { [weak self] _ in
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
        homeRepository.getHomeData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let roundId = data.roundGameId {
                    self.roundId = roundId
                    self.getRoundMissionData(roundId: roundId)
                    self.view.removeIndicator()
                }
            case .failure(let error):
                switch error {
                case .disconnectCouple:
                    self.view.removeIndicator()
                    UserDefaultsManager.shared.delete(.partnerId)
                    UserDefaultsManager.shared.delete(.userId)
                    UserDefaultsManager.shared.delete(.lastRoundId)
                    let navigationViewController = UINavigationController(rootViewController: LoginViewController())
                    self.changeRootViewController(navigationViewController)
                case .unknown:
                    self.view.removeIndicator()
                }
            }
        }
    }
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
}
