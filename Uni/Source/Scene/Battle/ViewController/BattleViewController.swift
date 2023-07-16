import UIKit
import SDSKit

class BattleViewController: BaseViewController {
    
    override func loadView() {
        super.loadView()
        self.view = battleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConfig()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addNotiObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeNotiObserver()
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
    
    @objc private func textViewMoveUp(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.transform = .init(translationX: 0, y: -keyboardSize.height)
            })
        }
    }
    
    @objc private func textViewMoveDown(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = .identity
        })
    }
    
    
    override func setConfig() {
        super.setConfig()
        self.battleView.collectionView.delegate = self
        self.battleView.collectionView.dataSource = self
        self.battleView.collectionView.register(SectionView.self,
                                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                withReuseIdentifier: SectionView.reuseIdentifier)
        self.battleView.collectionView.register(BattleCollectionViewCell.self,
                                                forCellWithReuseIdentifier: BattleCollectionViewCell.reuseIdentifier)
        self.battleView.collectionView.register(WishCollectionViewCell.self,
                                                forCellWithReuseIdentifier: WishCollectionViewCell.reuseIdentifier)
    }
    
    private let battleView = BattleView()
    
}
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
            headerView.bindText(title: "미션 카테고리 선택하기", subTitle: "더보기 버튼을 눌러 설명을 볼 수 있어요")
        default:
            headerView.bindText(title: "소원 정하기", subTitle: nil)
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return missionMokData.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BattleCollectionViewCell.reuseIdentifier, for: indexPath) as? BattleCollectionViewCell else {return UICollectionViewCell()}
            cell.bindText(iconImage: SDSIcon.icGooleLogin, title: missionMokData[indexPath.row].title)
            return cell
        default: // section 1
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishCollectionViewCell.reuseIdentifier, for: indexPath) as? WishCollectionViewCell else {return UICollectionViewCell()}
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BattleCollectionViewCell.reuseIdentifier, for: indexPath) as? BattleCollectionViewCell {
//        }
    }
}
extension BattleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: 82)
        default:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: 56)
        }
    }
}
