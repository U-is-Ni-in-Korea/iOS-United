import UIKit
import SDSKit
import SnapKit
import Then

class SelectBattleCategoryViewController: BaseViewController {
    // MARK: - Property
    var battleId: Int = 0
    var selectButtonCompletion: ((Int) -> Void)?
    var cellTapCompletion: ((Int) -> Void)?
    var completionHandler: (() -> Void)?
    var selectedBattleId: Int? // BattleViewController의 selectedBattleId와 동일한 타입
    var missionContent: String = ""
    var battleData: [BattleDataModel] = []
    var selectedCellArray: [Bool] = []
    let battleRepository = BattleRepository()
    // MARK: - UI Property
    let battleCategoryView = BattleCategoryView(type: .select)
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = battleCategoryView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBattleDetail()
        self.backButtonTap()
        self.addTarget()
    }
    // MARK: - Setting
    // MARK: - Action Helper
    private func addTarget() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(completeButtonTap))
        tapGesture.delegate = self
        self.battleCategoryView.creatButton.addGestureRecognizer(tapGesture)
    }
    private func backButtonTap() {
        self.battleCategoryView.navigationBar.backButtonCompletionHandler = { [weak self] in
            guard let self  = self else {return}
            self.navigationController?.popViewController(animated: true)
        }
    }
    // MARK: - @objc Methods
    @objc private func completeButtonTap() {
        let alert = view.showAlert(title: "설정된 내용으로 승부를 만들까요?",
                                              message: "한번 설정한 내용은 변경할 수 없어요",
                                              cancelButtonMessage: "취소",
                                              okButtonMessage: "만들기",
                                              type: .alert)
        alert.cancelButtonTapCompletion = { [weak self] in
            guard let self = self else { return }
            self.view.hideAlert(view: alert)
        }
        alert.okButtonTapCompletion = { [weak self] in
            guard let self = self else { return }
            self.makeBattle { [weak self] _ in
                guard let self = self else {return}
                completionHandler?()
                self.navigationController?.popViewController(animated: false)
            }
        }
    }
    // MARK: - Custom Method
    private func getBattleDetail() {
        battleRepository.getGameDetail(battleId: self.battleId) { [weak self] data in
            guard let strongSelf = self else {return}
            strongSelf.battleCategoryView.bindText(missionData: data,
                                                   contentList: data.missionContentList,
                                                   type: .select)
        }
    }
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
}
// MARK: - Extensions
extension SelectBattleCategoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
