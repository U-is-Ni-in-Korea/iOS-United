import UIKit
import SDSKit
import SnapKit
import Then

class SelectBattleCategoryViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBattleDetail()
        self.backButtonTap()
        self.addTarget()
    }
    
    override func loadView() {
        super.loadView()
        self.view = battleCategoryView
    }
    
    private func getBattleDetail() {
        battleRepository.getGameDetail(battleId: self.battleId) { [weak self] data in
            guard let strongSelf = self else {return}
            strongSelf.battleCategoryView.bindText(missionData: data,
                                                   contentList: data.missionContentList,
                                                   type: .select)
        }
    }
    
    private func backButtonTap() {
        self.battleCategoryView.navigationBar.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
        }
    }
    
    private func addTarget() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(completeButtonTap))
        tapGesture.delegate = self
        self.battleCategoryView.completeButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func completeButtonTap() {
        guard let completion = selectButtonCompletion else {return}
        completion(self.battleId)
        self.dismiss(animated: true)
    }
    
    let battleCategoryView = BattleCategoryView(type: .select)
    let battleRepository = BattleRepository()
    var battleId: Int = 0
    var selectButtonCompletion: ((Int) -> Void)?
}

extension SelectBattleCategoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
