import Foundation
import UIKit

final class SplashViewController: BaseViewController {
    // MARK: - Property
    private let keyChains = HeaderUtils()
    // MARK: - UI Property
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConfig()
        checkAndUpdateIfNeeded()
    }
    // MARK: - Setting
    override func setLayout() {
        super.setLayout()
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(208)
            $0.width.equalTo(220)
        }
    }
    override func setConfig() {
        super.setConfig()
        self.view.backgroundColor = .gray000
    }
    // MARK: - Custom Method
    private func setRootViewController() {
        let key = keyChains.read(account: "accessToken")
        let userDefaultsManager = UserDefaultsManager.shared
        if userDefaultsManager.hasOnboarded {
            if keyChains.isTokenExists(account: "accessToken") {
                ///로그인 + 토큰 존재
                if userDefaultsManager.hasCoupleCode {
                    if userDefaultsManager.hasPartnerId {
                        let homeViewController = HomeViewController()
                        changeRootViewController(UINavigationController(rootViewController: homeViewController))
                    } else {
                        let loginViewController = LoginViewController()
                        changeRootViewController(UINavigationController(rootViewController: loginViewController))
                    }
                } else {
                    let loginViewController = LoginViewController()
                    changeRootViewController(UINavigationController(rootViewController: loginViewController))
                }
            } else {
                let loginViewController = LoginViewController()
                changeRootViewController(UINavigationController(rootViewController: loginViewController))
            }
        }
        ///온보딩이 처음일 때
        else {
            let onboardingViewController = OnboardingViewController()
            changeRootViewController(onboardingViewController)
        }
    }
}
extension SplashViewController {
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    /*
     ex) 1.1.1 [Major, Minor, Patch] 업데이트에서
     Major, Minor - 강제 업데이트 MajorUpdate
     Patch - 선택 업데이트 MinorUpdate
     */
    func checkAndUpdateIfNeeded() {
        AppStoreCheck().latestVersion { [weak self] marketingVersion in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let marketingVersion = marketingVersion else {
                    print("앱스토어 버전을 찾지 못했습니다.")
                    return
                }
                let currentProjectVersion = AppStoreCheck.appVersion ?? ""
                let splitMarketingVersion = marketingVersion.split(separator: ".").compactMap { Int($0) }
                var splitMarketingVersionArray = [1, 0, 0]
                for i in 0..<splitMarketingVersion.count {
                    splitMarketingVersionArray[i] = splitMarketingVersion[i]
                }
                var splitCurrentProjectVersionArray = [0, 0, 0]
                let splitCurrentProjectVersion = currentProjectVersion.split(separator: ".").compactMap { Int($0) }
                for i in 0..<splitCurrentProjectVersion.count {
                    splitCurrentProjectVersionArray[i] = splitCurrentProjectVersion[i]
                }
                print(splitCurrentProjectVersionArray, "프로젝트 버전")
                print(splitMarketingVersionArray, "실제 앱스토어 버전")
                self.compareProjectVersion(projectVersion: splitCurrentProjectVersionArray, marketingVersion: splitMarketingVersionArray)
            }
        }
    }
    func compareProjectVersion(projectVersion: [Int], marketingVersion: [Int]) {
        if projectVersion.count > 0 && marketingVersion.count > 0 {
            if projectVersion[0] < marketingVersion[0] {
                self.showMajorUpdateAlert()
            } else if projectVersion[1] < marketingVersion[1] {
                self.showMajorUpdateAlert()
            } else if projectVersion[2] < marketingVersion[2] {
                self.checkAppVersion(nowAppVersion: marketingVersion)
            } else {
                print("현재 최신 버전입니다.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.setRootViewController()
                })
            }
        }
    }
    func checkAppVersion(nowAppVersion: [Int]) {
        let userDefaultsManager = UserDefaultsManager.shared
        if userDefaultsManager.hasAppVersion {
            let appVersion = userDefaultsManager.load(.appVersion) as! [Int]
            print(appVersion, "저장된 앱 버전")
            if appVersion != nowAppVersion {
                showMinorUpdateAlert()
                userDefaultsManager.save(value: nowAppVersion, forkey: .appVersion)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.setRootViewController()
                })
            }
        } else {
            userDefaultsManager.save(value: nowAppVersion, forkey: .appVersion)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.setRootViewController()
            })
        }
    }
    func showMajorUpdateAlert() {
        let alert = view.showAlert(title: "업데이트 알림", message: "더 나은 서비스로 찾아왔어요!", cancelButtonMessage: "", okButtonMessage: "업데이트", type: .noti)
        alert.okButtonTapCompletion = {
            AppStoreCheck().openAppStore()
        }
    }
    func showMinorUpdateAlert() {
        let alert = view.showAlert(title: "업데이트 알림", message: "더 나은 서비스로 찾아왔어요!", cancelButtonMessage: "취소", okButtonMessage: "업데이트", type: .alert)
        alert.okButtonTapCompletion = {
            AppStoreCheck().openAppStore()
        }
        alert.cancelButtonTapCompletion = { [weak self] in
            guard let self = self else { return }
            self.view.hideAlert(view: alert)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.setRootViewController()
            })
        }
    }
}
