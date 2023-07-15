//
//  OnboardingViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/10.
//

import UIKit


final class OnboardingViewController: BaseViewController {
    private var onboardingView = OnboardingView()
    
    private let numberOfPages : Int = 3
    var currentPage : Int = 0
    
    private let onboardingData = [
        OnboardingData(
            title: "다양한 카테고리의 미션을 함께 즐겨보세요",
            subTitle: "연인의 새로운 매력을 발견할 수 있어요",
            image: "pencil"),
        OnboardingData(
            title: "장기 승부와 한판 승부를 선택할 수 있어요",
            subTitle: "설렘 가득한 짜릿한 승부를 진행해 보세요",
            image: "pencil"),
        OnboardingData(
            title: "승부를 통해 우리 둘만의 소원권을 생성",
            subTitle: "소중한 추억을 만들고 기록할 수 있어요",
            image: "pencil")
    ]

    //MARK: - life cycle
    override func loadView() {
        super.loadView()
        onboardingView = OnboardingView(frame: self.view.frame)
        view = onboardingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConfig()
        
    }
    
    //MARK: - set view config
    override func setConfig() {
        super.setConfig()
        
        onboardingView.onboardingCollectionView.delegate = self
        onboardingView.onboardingCollectionView.dataSource = self
    }
    
    override func setLayout() {
        super.setLayout()
    }
    
    //MARK: - controll function
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }

        cell.titleLabel.text = onboardingData[indexPath.row].title
        cell.subTitleLabel.text = onboardingData[indexPath.row].subTitle
        cell.onboardingImageView.image = UIImage(systemName: onboardingData[indexPath.row].image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        print(currentPage)
        onboardingView.pageControl.currentPage = currentPage
    }

}
