//
//  OnboardingView.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/10.
//

import Foundation
import UIKit

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
        
        $0.pageIndicatorTintColor = .red
        $0.currentPageIndicatorTintColor = .black
    }
    
    let nextButton = UIButton().then {
        $0.backgroundColor = .red
        $0.setTitle("건너뛰기", for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setLayout() {
        self.backgroundColor = .systemBackground
        self.addSubviews([onboardingCollectionView, pageControl, nextButton])
        
        onboardingCollectionView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(self.safeAreaLayoutGuide)
            $0.top.lessThanOrEqualTo(self.safeAreaLayoutGuide).offset(72)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(82 + 52 + UIScreen.main.bounds.size.width - 40)
        }
        pageControl.snp.makeConstraints {
            $0.top.equalTo(onboardingCollectionView.snp.bottom).offset(42)
            $0.height.equalTo(26)
            $0.leading.trailing.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
            $0.height.equalTo(34)
            $0.width.equalTo(77)
        }
    }
    
}
