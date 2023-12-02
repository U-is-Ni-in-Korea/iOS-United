import UIKit

final class WithdrawViewController: BaseViewController {
    // MARK: - Property
    private let userRepository = UserRepository()
    private let keyChains = HeaderUtils()
    // MARK: - UI Property
    private var withdrawView = WithdrawView()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        setStyle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        withdrawViewActions()
    }
    // MARK: - Setting
    private func setStyle() {
        withdrawView = WithdrawView(frame: self.view.frame)
        self.view = withdrawView
    }
    // MARK: - Action Helper
    func withdrawViewActions() {
        self.withdrawView.askWithdrawAlertView.cancelButtonTapCompletion = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        self.withdrawView.askWithdrawAlertView.okButtonTapCompletion = {
            [weak self] in
            guard let self = self else { return }
            self.userRepository.deleteUserData { data in
                print("userdelete:", data.code)
                self.keyChains.delete("accessToken")
                UserDefaultsManager.shared.delete(.hasOnboarded)
                UserDefaultsManager.shared.delete(.lastRoundId)
                UserDefaultsManager.shared.delete(.userId)
                UserDefaultsManager.shared.delete(.partnerId)
                UserDefaultsManager.shared.delete(.hasCoupleCode)
                let splashViewController = SplashViewController()
                self.changeRootViewController(splashViewController)
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
