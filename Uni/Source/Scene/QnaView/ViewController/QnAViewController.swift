import UIKit
import SwiftUI

class QnAViewController: BaseViewController {
    // MARK: - UI Property
    private var qnaHostingController: UIHostingController<QnAView>!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
    }
    // MARK: - Setting
    override func setLayout() {
        qnaHostingController = UIHostingController(rootView: QnAView(viewModel: QnAViewModel(navigationController: self.navigationController!)))
        self.addChild(qnaHostingController)
        view.addSubview(qnaHostingController.view)
        qnaHostingController.didMove(toParent: self)
        qnaHostingController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
