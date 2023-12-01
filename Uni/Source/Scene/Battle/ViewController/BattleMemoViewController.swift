import Combine
import UIKit
import SwiftUI

final class BattleMemoViewController: BaseViewController {
    // MARK: - Property
    private var cancellables: [AnyCancellable] = []
    private let battleMemoViewData = BattleMemoViewData()
    // MARK: - UI Property
    private var battleMemoHostingController: UIHostingController<BattleMemoView>!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        setConfig()
        setLayout()
        addBackButtonAction()
    }
    // MARK: - Setting
    override func setConfig() {
        battleMemoHostingController = UIHostingController(rootView: BattleMemoView(viewData: battleMemoViewData))
        self.addChild(battleMemoHostingController)
        view.addSubview(battleMemoHostingController.view)
        battleMemoHostingController.didMove(toParent: self)
    }
    override func setLayout() {
        battleMemoHostingController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    // MARK: - Action Helper
    private func addBackButtonAction() {
        battleMemoViewData.dismissButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        .store(in: &cancellables)
    }
}
