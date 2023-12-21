//
//  CodeGeneratorViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/15.
//

import Foundation
import UIKit

final class CodeGeneratorViewController: BaseViewController {
    // MARK: - Property
     var inviteCode: String = ""
    private var codeGeneratorView = CodeGeneratorView()
    private let coupleJoinRepository = CoupleJoinRepository()

    // MARK: - UI Property
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        codeGeneratorView = CodeGeneratorView(frame: self.view.frame)
        view = codeGeneratorView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConfig()
        actions()
    }

    // MARK: - Setting
    override func setLayout() {
        super.setLayout()
    }
    override func setConfig() {
        super.setConfig()
        codeGeneratorView.codeLabel.text = inviteCode
    }
    // MARK: - Action Helper
    private func actions() {
        let shareButtonTapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(shareButtonTapped))
        shareButtonTapGesture.delegate = self
        codeGeneratorView.shareCodeButton.addGestureRecognizer(shareButtonTapGesture)
        let linkCheckButtonTapGesture = UITapGestureRecognizer(target: self,
                                                               action: #selector(linkCheckButtonTapped))
        linkCheckButtonTapGesture.delegate = self
        codeGeneratorView.connectionCheckButton.addGestureRecognizer(linkCheckButtonTapGesture)
        
        codeGeneratorView.shareCodeButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        codeGeneratorView.connectionCheckButton.addTarget(self, action: #selector(linkCheckButtonTapped), for: .touchUpInside)
        
        codeGeneratorView.navigationBarView.backButtonCompletionHandler = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    @objc func shareButtonTapped() {
        
        let activityViewController = UIActivityViewController(activityItems: [inviteCode], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true)
    }
    
    @objc func linkCheckButtonTapped() {
        codeGeneratorView.indicatorView.startAnimating()
        codeGeneratorView.indicatorView.isHidden = false
        
        CoupleJoinRepository.getCoupleJoin { value in
            if value {
                ///커플 연결
                self.codeGeneratorView.indicatorView.stopAnimating()
                let homeViewController = HomeViewController()
                self.changeRootViewController(UINavigationController(rootViewController: homeViewController))
            }
            else {
                ///커플 대기중
                self.codeGeneratorView.indicatorView.stopAnimating()
                self.codeGeneratorView.indicatorView.isHidden = true
                let hasSafeArea = self.checkHomeButtonDevice()
                self.view.showToast(message: "상대가 아직 연결되지 않았어요", hasSafeArea: hasSafeArea)
            }
        }

    }

    // MARK: - Custom Method
    func checkHomeButtonDevice() -> Bool {
        let screenHeight = UIScreen.main.bounds.size.height
        if screenHeight <= 736 {
            return false
        }
        else {
            return true
        }
    }
    
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
            print("이거")
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
            print("else")
        }
    }
}

extension CodeGeneratorViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
