import UIKit
import Combine

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Layout
    func setLayout() {}

    //MARK: - Config
    func setConfig() {}
    var cancellables: Set<AnyCancellable> = []
}
