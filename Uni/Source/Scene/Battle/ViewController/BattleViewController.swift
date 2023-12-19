import UIKit
import SDSKit

class BattleViewController: BaseViewController {
    // MARK: - Property
    var selectedBattleId: Int?
    var missionContent: String = ""
    var completionHandler: (() -> Void)?
    let timerViewData: TimerData
    private let battleRepository = BattleRepository()
    private var battleData: [BattleDataModel] = []
    private var selectedCellArray: [Bool] = []
    // MARK: - UI Property
    private let battleView = BattleView()
    // MARK: - Life Cycle
    init(timerViewData: TimerData) {
        self.timerViewData = timerViewData
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
        self.view = battleView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConfig()
        self.setButtonTarget()
        self.hideKeyboardWhenTappedAround()
        self.getBattleList()
        self.naviagationButtonTap()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addNotiObserver()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeNotiObserver()
    }
    // MARK: - Setting
    override func setConfig() {
        super.setConfig()
        self.battleView.collectionView.delegate = self
        self.battleView.collectionView.dataSource = self
        self.battleView.collectionView.register(SectionView.self,
                                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                withReuseIdentifier: SectionView.reuseIdentifier)
        self.battleView.collectionView.register(BattleCollectionViewCell.self,
                                                forCellWithReuseIdentifier: BattleCollectionViewCell.reuseIdentifier)
        self.battleView.collectionView.register(BattleWishCollectionViewCell.self,
                                                forCellWithReuseIdentifier: BattleWishCollectionViewCell.reuseIdentifier)
    }
    private func addNotiObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textViewMoveUp),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textViewMoveDown),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    private func removeNotiObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    // MARK: - Action Helper
    private func setButtonTarget() {
        self.battleView.navigationBar.rightBarRightButtonItemCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
        }
    }
    private func cellButtonTap(battleId: Int) {
        let battleCategoryView = SelectBattleCategoryViewController()
        battleCategoryView.completionHandler = { [weak self] in
            self?.completionHandler?()
            self?.dismiss(animated: false)
        }
        battleCategoryView.missionContent = self.missionContent
        battleCategoryView.battleId = battleId
        navigationController?.pushViewController(battleCategoryView, animated: true)
        battleCategoryView.selectButtonCompletion = { [weak self] battleId in
            guard let strongSelf = self else {return}
            if let index = strongSelf.battleData.firstIndex(where: { $0.id == battleId }) {
                strongSelf.resetSelectCellArray()
                strongSelf.selectedCellArray[index].toggle()
                strongSelf.selectedBattleId = strongSelf.battleData[index].id
                strongSelf.battleView.collectionView.reloadData()
            }
        }
    }
    // MARK: - @objc Methods
    @objc private func textViewMoveUp(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.transform = .init(translationX: 0, y: 0)
            })
        }
    }
    @objc private func textViewMoveDown(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = .identity
        })
    }
    private func resetSelectCellArray() {
        for index in 0 ... self.selectedCellArray.count - 1 {
            self.selectedCellArray[index] = false
        }
    }
    // MARK: - Custom Method
    private func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    private func getBattleList() {
        self.view.showIndicator()
        self.battleRepository.getGameList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.battleData = data
                for index in 0 ... data.count - 1 {
                    if index == 0 {
                        self.selectedBattleId = data[0].id
                        self.selectedCellArray.append(true)
                    }
                    self.selectedCellArray.append(false)
                }
                self.battleView.collectionView.reloadData()
                self.view.removeIndicator()
            case .failure(let error):
                switch error {
                case .disconnectCouple:
                    self.view.removeIndicator()
                    UserDefaultsManager.shared.delete(.partnerId)
                    UserDefaultsManager.shared.delete(.userId)
                    UserDefaultsManager.shared.delete(.lastRoundId)
                    let navigationViewController = UINavigationController(rootViewController: LoginViewController())
                    self.changeRootViewController(navigationViewController)
                case .emptyData:
                    self.view.removeIndicator()
                case .notFinish:
                    self.view.removeIndicator()
                }
            }
        }
    }
    private func makeBattle(completion: @escaping ((Int) -> Void)) {
        self.view.showIndicator()
        guard let missionId = self.selectedBattleId else {return}
        let wishContent = self.missionContent.setRemoveImoji()
        self.battleRepository.makeGame(missionId: missionId,
                                       wishContent: wishContent) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.view.removeIndicator()
                completion(data.roundGameID)
            case .failure(let error):
                switch error {
                case .gameAlreadyMade:
                    self.view.removeIndicator()
                    self.showToastMessage(text: "이미 생성된 승부가 있어요")
                case .serverError:
                    self.view.removeIndicator()
                    self.showToastMessage(text: "일시적인 오류로 서비스 접속에 실패했습니다")
                case .unknownError:
                    self.view.removeIndicator()
                }
            }
        }
    }
    private func naviagationButtonTap() {
        self.battleView.navigationBar.rightBarRightButtonItemCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            if strongSelf.selectedBattleId != nil {
                let alert = strongSelf.view.showAlert(title: "승부 만들기가 완료되지 않았어요",
                                                      message: "여기서 나가면 되돌릴 수 없어요",
                                                      cancelButtonMessage: "취소",
                                                      okButtonMessage: "나가기",
                                                      type: .alert)
                alert.okButtonTapCompletion = { [weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.dismiss(animated: true)
                }
                alert.cancelButtonTapCompletion = { [weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.view.hideAlert(view: alert)
                }
            } else {
                strongSelf.dismiss(animated: true)
            }
        }
    }
    private func checkHomeButtonDevice() -> Bool {
        let screenHeight = UIScreen.main.bounds.size.height
        if screenHeight <= 736 {
            return false
        } else {
            return true
        }
    }
    private func showToastMessage(text: String) {
        let hasSafeArea = self.checkHomeButtonDevice()
        self.view.showToast(message: text, hasSafeArea: hasSafeArea)
    }
}
// MARK: - Extensions
extension BattleViewController: UICollectionViewDelegate {}
extension BattleViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                        withReuseIdentifier: SectionView.reuseIdentifier, for: indexPath) as? SectionView else {return UICollectionReusableView()}
        switch indexPath.section {
        case 0:
            headerView.bindText(title: "소원 작성하기", subTitle: nil)
        default:
            headerView.bindText(title: "미션 카테고리 선택하기", subTitle: "원하는 카테고리를 선택해 보세요")
        }
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return battleData.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BattleWishCollectionViewCell.reuseIdentifier, for: indexPath) as? BattleWishCollectionViewCell else {return UICollectionViewCell()}
            cell.couponView.delegate = self
            cell.makeButtonTapCompletion = { [weak self] state in
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
                        strongSelf.makeBattle { [weak self] _ in
                            guard let self = self else {return}
                            let battleHistoryVC = BattleHistoryViewController(timerViewData: timerViewData)
                            battleHistoryVC.modalPresentationStyle = .overFullScreen
                            guard let pvc = strongSelf.presentingViewController else { return }
                            strongSelf.dismiss(animated: true) {
                                pvc.present(battleHistoryVC, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            return cell
        default: // section 1
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BattleCollectionViewCell.reuseIdentifier, for: indexPath) as? BattleCollectionViewCell else {return UICollectionViewCell()}
            cell.bindText(iconImage: battleData[indexPath.row].image,
                          title: battleData[indexPath.row].title)
//            cell.update(selectedCellArray[indexPath.item])
            cell.buttonTapCompletion = { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.cellButtonTap(battleId: strongSelf.battleData[indexPath.row].id)
            }
            return cell

        }
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.resetSelectCellArray()
        self.selectedCellArray[indexPath.item].toggle()
        self.selectedBattleId = battleData[indexPath.row].id
//        self.isCanMakeSession()
        collectionView.reloadData()
        return true
    }
}
extension BattleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: 56)
        default:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: 82)
        }
    }
}
extension BattleViewController: CouponTextDelegate {
    func getCouponText(text: String) {
        self.missionContent = text
    }
}
