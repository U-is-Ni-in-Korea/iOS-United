//
//  WishCouponCollectionView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/17.
//

import UIKit
import Then
import SDSKit
import CHTCollectionViewWaterfallLayout

final class WishCouponCollectionView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    let wishCouponCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CHTCollectionViewWaterfallLayout()).then {
        let layout = $0.collectionViewLayout as! CHTCollectionViewWaterfallLayout
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        layout.minimumInteritemSpacing = 18
        layout.minimumColumnSpacing = 15
        $0.register(WishCouponCollectionViewCell.self, forCellWithReuseIdentifier: WishCouponCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
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
        setStyle()
        setLayout()
        setDelegate()
    }
    
    // MARK: - Setting
    
    private func setDelegate() {
        wishCouponCollectionView.dataSource = self
        wishCouponCollectionView.delegate = self
    }
    
    private func setStyle() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        addSubview(wishCouponCollectionView)
        wishCouponCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}


// MARK: - UICollectionView Delegate
extension WishCouponCollectionView: UICollectionViewDelegate {}


// MARK: - UICollectionView Datasource
extension WishCouponCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = wishCouponCollectionView.dequeueReusableCell(withReuseIdentifier: WishCouponCollectionViewCell.identifier, for: indexPath) as? WishCouponCollectionViewCell
        else { return UICollectionViewCell() }
        
        if indexPath.item == 0 {
            cell.configure(with: .noTitle)
        } else {
            cell.configure(with: .title)
        }
        return cell
    }
}


extension WishCouponCollectionView: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let columnSpacing = 30
        
        let itemWidthSize = (UIScreen.main.bounds.width - 55) / 2
        // 셀의 크기를 반환
        if indexPath.item == 0 {
            return CGSize(width: itemWidthSize, height: 122)
        } else {
            return CGSize(width: itemWidthSize, height: itemWidthSize / 160 * 206)
        }
    }
}
