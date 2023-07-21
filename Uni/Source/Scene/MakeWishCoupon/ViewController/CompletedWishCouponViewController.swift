//
//  CompletedWishCouponViewController.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/19.
//

import UIKit

class CompletedWishCouponViewController: BaseViewController {

    // MARK: - Property
    
    private var completedWishCouponView = CompletedWishCouponView()
    
    // MARK: - UI Property
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        setConfig()
        setNavigationBarCompletion()
//        completedWishCouponView.makeWishButton.setButtonTitle(title: "소원권 사용하기")
    }
    
    override func loadView() {
        super.loadView()
        completedWishCouponView = CompletedWishCouponView(frame: self.view.frame)
        self.view = completedWishCouponView
    }
    
    // MARK: - Setting
    override func setConfig() {
        super.setConfig()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(homeButtonTap))
        tapGesture.delegate = self
        self.completedWishCouponView.homeButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func homeButtonTap() {
        //홈으로 돌아가기
        let homeVC = HomeViewController()
        self.dismiss(animated: true)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    private func setNavigationBarCompletion() {
        self.completedWishCouponView.makeWishViewNavi.rightBarRightButtonItemCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
            
        }
    }
    
    private func setStyle() {
        
    }
    
    override func setLayout() {
        
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    


}
extension CompletedWishCouponViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
