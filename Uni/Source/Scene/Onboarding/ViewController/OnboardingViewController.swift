//
//  OnboardingViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/10.
//

import UIKit


final class OnboardingViewController: BaseViewController {
    // MARK: - Property
    private let onboardingData = [
        OnboardingDataModel(
            title: "다양한 카테고리의 미션을 함께 즐겨보세요",
            subTitle: "연인의 새로운 매력을 발견할 수 있어요",
            image: "onboarding1"),
        OnboardingDataModel(
            title: "장기 승부와 한판 승부를 선택할 수 있어요",
            subTitle: "설렘 가득한 짜릿한 승부를 진행해 보세요",
            image: "onboarding2"),
        OnboardingDataModel(
            title: "승부를 통해 우리 둘만의 소원권을 생성",
            subTitle: "소중한 추억을 만들고 기록할 수 있어요",
            image: "onboarding3")
    ]
    private let numberOfPages : Int = 3
    var currentPage : Int = 0
    
    // MARK: - UI Property
    private var onboardingView = OnboardingView()


    //MARK: - life cycle
    override func loadView() {
        super.loadView()
        onboardingView = OnboardingView(frame: self.view.frame)
        view = onboardingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        actions()
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
    
    // MARK: - Action Helper
    private func actions() {
        onboardingView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Custom Method
    @objc func nextButtonTapped() {
        
        UserDefaultsManager.shared.save(value: true, forkey: .hasOnboarded)
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }

        cell.configureCell(onboardingData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = lround(Double(scrollView.contentOffset.x / scrollView.frame.width))
        onboardingView.pageControl.currentPage = currentPage
    }

}
