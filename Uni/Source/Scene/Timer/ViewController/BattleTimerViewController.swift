import Combine
import UIKit
import SwiftUI

final class BattleTimerViewController: BaseViewController {
    // MARK: - Property
    let timerData: TimerData
    private let timerViewData = TimerViewData()
    private var cancellables: [AnyCancellable] = []
    // MARK: - UI Property
    private var battleTimerHostingController: UIHostingController<TimerView>!
    // MARK: - Life Cycle
    init(timerViewData: TimerData) {
        self.timerData = timerViewData
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        setLayout()
        addNavigationButtonAction()
    }
    // MARK: - Setting
    override func setConfig() {
        battleTimerHostingController = UIHostingController(rootView: TimerView(timerData: timerData, timerViewData: timerViewData))
        self.addChild(battleTimerHostingController)
        view.addSubview(battleTimerHostingController.view)
        battleTimerHostingController.didMove(toParent: self)
    }
    override func setLayout() {
        battleTimerHostingController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    // MARK: - Action Helper
    private func addNavigationButtonAction() {
        timerViewData.popButtonTapPublisher.sink { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        .store(in: &cancellables)
    }
}
