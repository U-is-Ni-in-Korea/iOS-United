import UIKit
import SwiftUI

class QnAViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
    }
    
    override func setLayout() {
        self.view.backgroundColor = .white
        let inputNickNameView = UIHostingController(rootView: QnAView(viewModel: QnAViewModel(navigationController: self.navigationController!)))
        self.view.addSubview(inputNickNameView.view)
        
        inputNickNameView.view.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
    }

}
