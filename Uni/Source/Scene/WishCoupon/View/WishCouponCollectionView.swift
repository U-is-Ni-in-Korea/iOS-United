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
        layout.minimumInteritemSpacing = 15
        $0.contentInset = .init(top: 16, left: 20, bottom: 120, right: 20)
        $0.register(WishCouponCollectionViewCell.self, forCellWithReuseIdentifier: WishCouponCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = true
        $0.alwaysBounceVertical = true
    }
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setStyle()
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        self.backgroundColor = .gray100
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}
