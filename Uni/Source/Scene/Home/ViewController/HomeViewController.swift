import UIKit

final class HomeViewController: BaseViewController {
    let homeView = HomeView()
    private let homeRepository = HomeRepository()
    private var homeData: HomeDataModel?
    
    //MARK: - life cycle
    override func loadView() {
        super.loadView()
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addEvent()
        self.getHomeList()
        
        
        //        let tokenUtil = HeaderUtils()
        //        tokenUtil.delete("accessToken")
        //        tokenUtil.create(account: "accessToken", value: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhY2Nlc3NUb2tlbiIsImlhdCI6MTY4OTQ1MzY1OCwiZXhwIjoxNjkxMjUzNjU4LCJ1c2VySWQiOjd9.vgY_Iz1OcONRJYzgvRPOL_iUDyyK_JMnlYzs8yn2iP2668bUr8KHplUxX5k6gTog")
    }
    
    //MARK: - set view config
    override func setConfig() {
        super.setConfig()
    }
    
    override func setLayout() {
        super.setLayout()
    }
    
    //MARK: - controll function
    private func addEvent() {
        let battleGesture = UITapGestureRecognizer(target: self,
                                                   action: #selector(battleViewTapped(_:)))
        battleGesture.delegate = self
        self.homeView.battleView.shortBattleButton.addGestureRecognizer(battleGesture)
        let wishGesture = UITapGestureRecognizer(target: self,
                                                 action: #selector(wishCouponViewTapped(_:)))
        wishGesture.delegate = self
        self.homeView.battleView.wishCouponButton.addGestureRecognizer(wishGesture)
    }
    
    private func didProgressGameExist(completion: @escaping ((Bool?) -> Void)) {
        // if data.shortGame == nil
        //if data.shortGame?.enable == false -> 입력창
        //if data.shortGame?.enable == ture -> 결과창
        if self.homeData?.shortGame == nil {
            completion(nil)
        } else {
            if let roundId = homeData?.roundGameId {
                self.homeRepository.isWriteGameState(roundGameId: roundId) { [weak self] state in
                    completion(state)
                }
            }
        }
    }
    
    private func transitionView() {
        self.didProgressGameExist { [weak self] state in
            guard let strongSelf = self else {return}
            if state == nil {
                let createBattleVC = BattleViewController()
                createBattleVC.modalPresentationStyle = .overFullScreen
                strongSelf.present(createBattleVC, animated: true)
            }
            else if state! {
                let historyVC = BattleResultViewController()
                historyVC.modalPresentationStyle = .overFullScreen
                strongSelf.present(historyVC, animated: true)
            } else {
                let resultVC = BattleHistoryViewController()
                resultVC.modalPresentationStyle = .overFullScreen
                strongSelf.present(resultVC, animated: true)
            }
        }
    }

    
    @objc private func battleViewTapped(_ sender: UIGestureRecognizer) {
        //기존의 저장된 밸류와 다르면 화면 전환
        isAlreaydGameFinish { [weak self] state in
            guard let strongSelf = self else {return}
            if state {
                strongSelf.getHomeList()
                strongSelf.view.showToast(message: "승부가 이미 완료되었습니다.", hasSafeArea: true)
            } else {
                strongSelf.transitionView()
            }
        }
    }
    
    @objc private func wishCouponViewTapped(_ sender: UIGestureRecognizer) {
        let wishCouponVC = WishCouponViewController()
        self.navigationController?.pushViewController(wishCouponVC, animated: true)
    }
    
    
    //MARK: - DataBinding
    private func getHomeList() {
        self.view.showIndicator()
        self.homeRepository.getHomeData { [weak self] data in
            guard let strongSelf = self else {return}
            //비교를 위한 alreadyFinish flag 추가
            UserDefaultsManager.shared.save(value: data.shortGame == nil ? false: true, forkey: .isAlreadyFinish)
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
    
    //이미 끝난 게임인지 확인용
    private func isAlreaydGameFinish(completion: @escaping ((Bool) -> Void)) {
        self.view.showIndicator()
        self.homeRepository.isAlreadyGameFinish { [weak self] state in
            guard let strongSelf = self else {return}
            strongSelf.view.removeIndicator()
            completion(state)
        }
    }
    
    
    
}
extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
