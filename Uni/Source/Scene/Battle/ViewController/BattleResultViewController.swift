import Combine
import UIKit
import SwiftUI

final class BattleResultViewController: BaseViewController {
    // MARK: - Property
    var roundId: Int = 0
    private let battlerRepository = BattleRepository()
//    private var battelData: RoundBattleDataModel?
    private var cancellables: [AnyCancellable] = []
    private let battleResultViewData = BattleResultViewData()
    // MARK: - UI Property
    private var battleResultHostingViewController: UIHostingController<BattleResultView>!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        setLayout()
        getBattleResult()
        addNavigationButtonAction()
        checkResultButtonAction()
        goHomeButtonAction()
        findWishCouponButtonAction()
    }
    // MARK: - Setting
    override func setConfig() {
        battleResultHostingViewController = UIHostingController(rootView: BattleResultView(data: battleResultViewData))
        self.addChild(battleResultHostingViewController)
        view.addSubview(battleResultHostingViewController.view)
        battleResultHostingViewController.didMove(toParent: self)
    }
    override func setLayout() {
        battleResultHostingViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    // MARK: - Action Helper
    private func addNavigationButtonAction() {
        battleResultViewData.dismissButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }.store(in: &cancellables)
    }
    private func checkResultButtonAction() {
        battleResultViewData.checkResultButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            getFinalBattleResult()
        }.store(in: &cancellables)
    }
    private func goHomeButtonAction() {
        battleResultViewData.goHomeButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }.store(in: &cancellables)
    }
    private func findWishCouponButtonAction() {
        battleResultViewData.findWishCouponButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            let wishCouponVC = WishCouponViewController()
            guard let presentingViewController = self.presentingViewController else { return }
            self.dismiss(animated: true) {
                if let navigation = presentingViewController as? UINavigationController {
                    navigation.pushViewController(wishCouponVC, animated: true)
                }
            }
        }.store(in: &cancellables)
    }
    // MARK: - Custom Method
    private func getBattleResult() {
        self.view.showIndicator()
        print("getBattleResult 시작전")
        battlerRepository.getRoundGameData(roundId: self.roundId) { [weak self] data in
            guard let strongSelf = self else {return}
            print("getBattleResult")
            print(data, "get 데이터")
            strongSelf.battleResultViewData.roundData = data
            strongSelf.view.removeIndicator()
        }
    }
    private func getFinalBattleResult() {
        self.view.showIndicator()
        battlerRepository.getBattleResultData(roundId: roundId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                if value?.partnerRoundMission == nil {
                    self.showToastMessage(text: "상대가 결과를 입력하기 전이에요")
                }
                self.battleResultViewData.battleResultData = value
                self.view.removeIndicator()
            case .failure(let error):
                print(error)
                self.view.removeIndicator()
            }
            print(result)
        }
    }
    func checkHomeButtonDevice() -> Bool {
        let screenHeight = UIScreen.main.bounds.size.height
        if screenHeight <= 736 {
            return false
        }
        else {
            return true
        }
    }
    func showToastMessage(text: String) {
        let hasSafeArea = self.checkHomeButtonDevice()
        self.view.showToast(message: text, hasSafeArea: hasSafeArea)
    }
}
