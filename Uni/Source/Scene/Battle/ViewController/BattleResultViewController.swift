import UIKit
import SDSKit
import SnapKit
import Then

final class BattleResultViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.view = battleResultView
    }
    
    private let battleResultView = BattleResultView()

}
