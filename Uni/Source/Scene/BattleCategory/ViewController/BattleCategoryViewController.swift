import UIKit
import SDSKit
import SnapKit
import Then

class BattleCategoryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.view = battleCategoryView
    }
    
    let battleCategoryView = BattleCategoryView(type: .none)
}
