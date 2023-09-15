import UIKit

final class HomeViewController: BaseViewController {
    // MARK: - Property
    private var homeData: HomeDataModel?
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
        getHomeList()
        setNotifications()
    }
    // MARK: - Setting
    override func setConfig() {
        super.setConfig()
    }
    override func setLayout() {
        super.setLayout()
    }
    // MARK: - Action Helper
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
        let myPageViewController = SettingViewController()
        self.navigationController?.pushViewController(myPageViewController, animated: true)
    }
    @objc private func historyButtonTapped() {
        let historyViewController = HistoryViewController()
        self.navigationController?.pushViewController(historyViewController, animated: true)
    }
    @objc private func battleViewTapped(_ sender: UIGestureRecognizer) {
        // 기존의 저장된 밸류와 다르면 화면 전환
        isAlreaydGameFinish { [weak self] state in
            guard let strongSelf = self else {return}
            if state { //
                strongSelf.getHomeList()
                strongSelf.view.showToast(message: "승부가 이미 완료되었습니다.", hasSafeArea: true)
            } else {
                strongSelf.transitionView()
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
    private func setNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(getHomeAPI(_:)), name: NSNotification.Name("sceneDidBecomeActive"), object: nil)
    }
    private func didProgressGameExist(completion: @escaping ((Bool?) -> Void)) {
        // if data.shortGame == nil
        // if data.shortGame?.enable == false -> 입력창
        // if data.shortGame?.enable == ture -> 결과창
        if self.homeData?.shortGame == nil {
            completion(nil)
        } else {
            if let roundId = homeData?.roundGameId {
                self.homeRepository.isWriteGameState(roundGameId: roundId) { state in
                    completion(state)
                }
            } else {
                completion(nil)
            }
        }
    }
    private func transitionView() {
        self.didProgressGameExist { [weak self] state in
            guard let strongSelf = self else {return}
            if state == nil {
                let createBattleViewController = BattleViewController()
                createBattleViewController.modalPresentationStyle = .overFullScreen
                strongSelf.present(createBattleViewController, animated: true)
            } else if state! {
                let historyViewController = BattleResultViewController()
                if let roundId = strongSelf.homeData?.roundGameId {
                    historyViewController.roundId = roundId
                }
                let navigationController = UINavigationController(rootViewController: historyViewController)
                navigationController.modalPresentationStyle = .overFullScreen
                strongSelf.present(navigationController, animated: true, completion: nil)
            } else {
                let resultViewController = BattleHistoryViewController()
                resultViewController.modalPresentationStyle = .overFullScreen
                strongSelf.present(resultViewController, animated: true)
            }
        }
    }
    // MARK: - DataBinding
    private func getHomeList() {
        view.showIndicator()
        homeRepository.getHomeData { [weak self] data in
            guard let strongSelf = self else {return}
            // 비교를 위한 alreadyFinish flag 추가
            if UserDefaultsManager.shared.load(.userId) != nil {
                UserDefaultsManager.shared.save(value: data.userID, forkey: .userId)
            }
            if UserDefaultsManager.shared.load(.partnerId) != nil {
                UserDefaultsManager.shared.save(value: data.partnerId, forkey: .partnerId)
            }
            strongSelf.homeData = data
            strongSelf.homeView.bindData(myScore: data.myScore,
                                         partnerScore: data.partnerScore,
                                         drawScore: data.drawCount,
                                         dDay: data.dDay,
                                         heartCount: data.couple.heartToken,
                                         isPlayingBattle: data.shortGame == nil ? false: true)
            strongSelf.view.removeIndicator()
        }
    }
    // 이미 끝난 게임인지 확인용
    private func isAlreaydGameFinish(completion: @escaping ((Bool) -> Void)) {
        self.view.showIndicator()
        self.homeRepository.isAlreadyGameFinish { [weak self] state in
            guard let strongSelf = self else {return}
            strongSelf.view.removeIndicator()
            completion(state)
        }
    }
}
// MARK: - Extensions
extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
