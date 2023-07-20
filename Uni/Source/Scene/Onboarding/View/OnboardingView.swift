//
//  OnboardingView.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/10.
//

import Foundation
import UIKit
import SDSKit

final class OnboardingView: UIView {
    
    //MARK: - properties
    let onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let pageControl = UIPageControl().then {
        $0.numberOfPages = 3
        $0.currentPage = 0
        $0.isUserInteractionEnabled = false
        $0.pageIndicatorTintColor = .lightBlue100
        $0.currentPageIndicatorTintColor = .lightBlue600
    }
    
    let nextButton = UIButton().then {
        $0.setTitleColor(.lightBlue600, for: .normal)
        $0.setTitle("시작하기", for: .normal)
        $0.titleLabel?.font = SDSFont.body2.font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setConfigure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setConfigure() {
        self.backgroundColor = .gray000
    }
    
    private func setLayout() {
        self.addSubviews([onboardingCollectionView, pageControl, nextButton])
        
        onboardingCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            let height: Double = 88 + 50 + 52
            let adjustedHeight = UIScreen.main.bounds.width - 40
            $0.height.equalTo(height.adjustedH + adjustedHeight)
        }
        pageControl.snp.makeConstraints {
            $0.top.equalTo(onboardingCollectionView.snp.bottom).offset(42.adjustedH)
            $0.height.equalTo(26)
            $0.leading.trailing.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(5)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
            $0.height.equalTo(34)
            $0.width.equalTo(77)
        }
    }
    
}
