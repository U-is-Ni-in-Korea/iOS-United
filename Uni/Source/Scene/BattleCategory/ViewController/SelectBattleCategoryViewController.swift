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
        self.battleCategoryView.creatButton.addGestureRecognizer(tapGesture)
    }
    
    var selectedBattleId: Int? // BattleViewController의 selectedBattleId와 동일한 타입
    var missionContent: String = ""
    var battleData: [BattleDataModel] = []
    var selectedCellArray: [Bool] = []
    
    //MARK: -network func
    
    private func makeBattle(completion: @escaping ((Int) -> Void)) {
        self.view.showIndicator()
        
        guard let missionId = self.selectedBattleId else {return}
        let wishContent = self.missionContent.setRemoveImoji()
        self.battleRepository.makeGame(missionId: missionId,
                                       wishContent: wishContent) { [weak self] data in
            guard let strongSelf = self else {return}
            print(data)
            strongSelf.view.removeIndicator()
            completion(data.roundGameID)
        }
    }
    
    @objc private func completeButtonTap() {
//        guard let completion = selectButtonCompletion else {return}
//        completion(self.battleId)
//        self.dismiss(animated: true)
        battleCategoryView.makeButtonTapCompletion = { [weak self] state in
            guard let strongSelf = self else {return}
            if state == .enabled {
                guard let strongSelf = self else {return}
                let alert = strongSelf.view.showAlert(title: "설정된 내용으로 승부를 만들까요?",
                                                      message: "한번 설정한 내용은 변경할 수 없어요",
                                                      cancelButtonMessage: "취소",
                                                      okButtonMessage: "만들기",
                                                      type: .alert)
                
                alert.cancelButtonTapCompletion = { [weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.view.hideAlert(view: alert)
                }
                
                alert.okButtonTapCompletion = { [weak self] in
                    strongSelf.makeBattle { [weak self] roundId in
                        guard let strongSelf = self else {return}
                        let battleHistoryVC = BattleHistoryViewController()
                        battleHistoryVC.modalPresentationStyle = .overFullScreen
                        guard let pvc = strongSelf.presentingViewController else { return }
                        strongSelf.dismiss(animated: true) {
                            pvc.present(battleHistoryVC, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    let battleCategoryView = BattleCategoryView(type: .select)
    let battleRepository = BattleRepository()
    var battleId: Int = 0
    var selectButtonCompletion: ((Int) -> Void)?
    var cellTapCompletion: ((Int) -> Void)?
}

extension SelectBattleCategoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
