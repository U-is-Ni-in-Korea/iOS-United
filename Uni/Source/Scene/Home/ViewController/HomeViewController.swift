import UIKit

final class HomeViewController: BaseViewController {
    // MARK: - Property
    private var homeData: HomeDataModel?
    let timerViewData = TimerData()
    // MARK: - UI Property
    let homeView = HomeView()
    private let homeRepository = HomeRepository()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = homeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvent()
        saveHasCoupleStatus()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeList()
    }
    // MARK: - Setting
    override func setConfig() {
        super.setConfig()
    }
    override func setLayout() {
        super.setLayout()
    }
    // MARK: - Action Helper
    private func saveHasCoupleStatus() {
        if !UserDefaultsManager.shared.hasCoupleCode {
            UserDefaultsManager.shared.save(value: true, forkey: .hasCoupleCode)
        }
    }
    private func addEvent() {
        homeView.myPageButton.addTarget(self, action: #selector(myPageButtonTapped), for: .touchUpInside)
        homeView.scoreView.historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        let battleGesture = UITapGestureRecognizer(target: self,
                                                   action: #selector(battleViewTapped(_:)))
        battleGesture.delegate = self
        self.homeView.battleView.shortBattleButton.addGestureRecognizer(battleGesture)
        let wishGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(wishCouponViewTapped(_:)))
        wishGesture.delegate = self
        self.homeView.battleView.wishCouponButton.addGestureRecognizer(wishGesture)
    }
    // MARK: - @objc Methods
    @objc private func myPageButtonTapped() {
        let myPageViewController = MyPageViewController()
        self.navigationController?.pushViewController(myPageViewController, animated: true)
    }
    @objc private func historyButtonTapped() {
        let historyViewController = BattleHistoryResultViewController()
        self.navigationController?.pushViewController(historyViewController, animated: true)
    }
    @objc private func battleViewTapped(_ sender: UIGestureRecognizer) {
        homeRepository.getHomeData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.homeView.bindData(myScore: data.myScore,
                                             partnerScore: data.partnerScore,
                                             drawScore: data.drawCount,
                                             dDay: data.dDay,
                                             heartCount: data.couple.heartToken,
                                             isPlayingBattle: data.shortGame == nil ? false: true)
                self.transitionView(checkHomeData: data)
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
    @objc private func wishCouponViewTapped(_ sender: UIGestureRecognizer) {
        let wishCouponViewController = WishCouponViewController()
        self.navigationController?.pushViewController(wishCouponViewController, animated: true)
    }
    @objc private func getHomeAPI(_ notification: Notification) {
        getHomeList()
    }
    // MARK: - Custom Method
    private func didProgressGameExist(homeDataModel: HomeDataModel?, completion: @escaping ((Bool?) -> Void)) {
        // if data.shortGame == nil
        // if data.shortGame?.enable == false -> 입력창
        // if data.shortGame?.enable == ture -> 결과창
        if homeDataModel?.shortGame == nil {
            completion(nil)
        } else {
            if let roundId = homeDataModel?.roundGameId {
                self.homeRepository.isWriteGameState(roundGameId: roundId) { result in
                    switch result {
                    case .success(let data):
                        completion(data)
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
            } else {
                completion(nil)
            }
        }
    }
    private func transitionView(checkHomeData: HomeDataModel?) {
        self.didProgressGameExist(homeDataModel: checkHomeData
        ) { [weak self] state in
            if state == nil {
                guard let self = self else {return}
                let createBattleViewController = BattleViewController(timerViewData: timerViewData)
                let navigationController = UINavigationController(rootViewController: createBattleViewController)
                navigationController.modalPresentationStyle = .overFullScreen
                self.present(navigationController, animated: true)
                createBattleViewController.completionHandler = { [weak self] in
                    guard let self = self else { return }
                    let battleHistoryViewController = BattleProgressViewController(timerViewData: timerViewData)
                    DispatchQueue.main.async {
                        let navigationController = UINavigationController(rootViewController: battleHistoryViewController)
                        navigationController.modalTransitionStyle = .crossDissolve
                        navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true)
                    }
                }
            } else if state! {
                guard let self = self else {return}
                let historyViewController = BattleResultViewController()
                if let roundId = self.homeData?.roundGameId {
                    historyViewController.roundId = roundId
                }
                let navigationController = UINavigationController(rootViewController: historyViewController)
                navigationController.modalPresentationStyle = .overFullScreen
                navigationController.modalTransitionStyle = .crossDissolve
                self.present(navigationController, animated: true, completion: nil)
            } else {
                guard let self = self else { return }
                let battleHistoryViewController = BattleProgressViewController(timerViewData: timerViewData)
                let navigationController = UINavigationController(rootViewController: battleHistoryViewController)
                navigationController.modalTransitionStyle = .crossDissolve
                navigationController.modalPresentationStyle = .overFullScreen
                self.present(navigationController, animated: true)
            }
        }
    }
    // MARK: - DataBinding
    private func getHomeList() {
        view.showIndicator()
        homeRepository.getHomeData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print(data, "홈데이터, ??????")
                if UserDefaultsManager.shared.load(.userId) != nil {
                    UserDefaultsManager.shared.save(value: data.userID, forkey: .userId)
                }
                if UserDefaultsManager.shared.load(.partnerId) != nil {
                    if let partnerId = data.partnerId {
                        UserDefaultsManager.shared.save(value: partnerId, forkey: .partnerId)
                    }
                }
                self.homeData = data
                self.homeView.bindData(myScore: data.myScore,
                                             partnerScore: data.partnerScore,
                                             drawScore: data.drawCount,
                                             dDay: data.dDay,
                                             heartCount: data.couple.heartToken,
                                             isPlayingBattle: data.shortGame == nil ? false: true)
                self.view.removeIndicator()
            case .failure(let error):
                print(error.rawValue, "되나")
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
// MARK: - Extensions
extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
