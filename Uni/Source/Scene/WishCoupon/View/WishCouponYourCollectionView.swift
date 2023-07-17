//
//  WishCouponYourCollectionView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/17.
//

import UIKit
import Then
import SDSKit

final class WishCouponYourCollectionView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    let wishCouponFlowLayout = UICollectionViewFlowLayout()
        
    lazy var wishCouponYourCollectionView = UICollectionView(frame: .zero, collectionViewLayout: wishCouponFlowLayout).then {
        $0.register(WishCouponYourCollectionViewCell.self, forCellWithReuseIdentifier: WishCouponYourCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = .init(top: 16, left: 20, bottom: 120, right: 20)
        $0.alwaysBounceVertical = true
        $0.backgroundColor = .clear
    }
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setDelegate()
        setStyle()
        setLayout()
    }
    
    // MARK: - Setting
    
    private func setDelegate() {
        wishCouponYourCollectionView.dataSource = self
        wishCouponYourCollectionView.delegate = self
    }
    
    private func setStyle() {
        self.backgroundColor = .clear
        let itemWidthSize = (UIScreen.main.bounds.width - 55) / 2
        wishCouponFlowLayout.scrollDirection = .vertical
        wishCouponFlowLayout.itemSize = .init(width: itemWidthSize, height: itemWidthSize / 160 * 206)
        wishCouponFlowLayout.minimumLineSpacing = 15
        wishCouponFlowLayout.minimumInteritemSpacing = 15
    }
    
    private func setLayout() {
        addSubview(wishCouponYourCollectionView)
        wishCouponYourCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}


// MARK: - UICollectionView Delegate
extension WishCouponYourCollectionView: UICollectionViewDelegate {}


// MARK: - UICollectionView Datasource
extension WishCouponYourCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = wishCouponYourCollectionView.dequeueReusableCell(withReuseIdentifier: WishCouponYourCollectionViewCell.identifier, for: indexPath) as? WishCouponYourCollectionViewCell
        else { return UICollectionViewCell() }
//        cell.configureCell(with: postDummyData[indexPath.row])
        return cell
    }
}
