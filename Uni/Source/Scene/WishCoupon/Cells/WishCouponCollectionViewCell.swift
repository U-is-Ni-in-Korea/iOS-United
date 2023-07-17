//
//  WishCouponCollectionViewCell.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/17.
//

import UIKit
import Then
import SDSKit
import CHTCollectionViewWaterfallLayout

final class WishCouponCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI Property
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        
    }
    
    private func setLayout() {
        
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    

    
}
