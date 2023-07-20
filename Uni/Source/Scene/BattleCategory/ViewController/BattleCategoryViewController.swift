import UIKit
import SDSKit
import SnapKit
import Then

class BattleCategoryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBattleCategory()
        self.setBackButtonAction()
    }
    
    override func loadView() {
        super.loadView()
        self.view = battleCategoryView
    }
    
    private func getBattleCategory() {
        self.battleRepository.getGameDetail(battleId: self.missionId) { [weak self] data in
            guard let strongSelf = self else {return}
            strongSelf.battleCategoryView.bindText(missionData: data,
                                              type: .none)
        }
    }
    
    private func setBackButtonAction() {
        self.battleCategoryView.navigationBar.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
        }
    }
    
    private let battleCategoryView = BattleCategoryView(type: .none)
    private let battleRepository = BattleRepository()
    
    var missionId: Int = 0
}
