import UIKit

final class LogoutViewController: BaseViewController {
    // MARK: - Property
    private let keyChains = HeaderUtils()
    // MARK: - UI Property
    private var logoutView = LogoutView()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        setStyle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutViewActions()
        logoutDoneActions()
    }
    // MARK: - Setting
    private func setStyle() {
        logoutView = LogoutView(frame: self.view.frame)
        self.view = logoutView
    }
    // MARK: - Action Helper
    private func logoutViewActions() {
        self.logoutView.askLogoutAlertView.cancelButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
        }
    }
    private func logoutDoneActions() {
        self.logoutView.askLogoutAlertView.okButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            if strongSelf.keyChains.isTokenExists(account: "accessToken") {
                strongSelf.keyChains.delete("accessToken")
                UserDefaultsManager.shared.delete(.lastRoundId)
                UserDefaultsManager.shared.delete(.userId)
                UserDefaultsManager.shared.delete(.partnerId)
                let loginViewController = LoginViewController()
                strongSelf.changeRootViewController(UINavigationController(rootViewController: loginViewController))
            }
        }
    }
    // MARK: - Custom Method
    private func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
}
