import Foundation
import UIKit
import SDSKit
import SnapKit
import Then

final class BattleView: UIView {
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    init() {
        super.init(frame: .zero)
        self.setLayout()
        self.setCollectionViewFlowLayout()
    }
    // MARK: - Setting
    private func setLayout() {
        self.backgroundColor = .gray100
        self.addSubviews([collectionView, navigationBar])
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        navigationBar.backgroundColor = .gray100
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        collectionView.backgroundColor = .gray100
    }
    private func setCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = floor((UIScreen.main.bounds.width / 2) - 25)
        layout.estimatedItemSize = .init(width: itemWidth,
                                         height: 78.adjusted)
        layout.minimumLineSpacing = 9
        layout.minimumInteritemSpacing = 9
        layout.sectionInset = .init(top: 0, left: 0, bottom: 48, right: 0)
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        self.collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    let navigationBar = SDSNavigationBar(hasBack: false,
                                                 hasTitleItem: false,
                                                 navigationTitle: "한판 승부",
                                                 rightBarButtonImages: [SDSIcon.icDismiss])
    let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.alwaysBounceVertical = true
    }
}
