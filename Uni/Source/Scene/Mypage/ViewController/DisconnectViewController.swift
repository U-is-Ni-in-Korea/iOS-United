import UIKit

final class DisconnectViewController: BaseViewController {
    // MARK: - Property
    private let coupleRepository = CoupleJoinRepository()
    // MARK: - UI Property
    private var disconnectView = DisconnectView()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        disconnectViewActions()
    }
    override func loadView() {
        super.loadView()
        setStyle()
    }
    // MARK: - Setting
    private func setStyle() {
        disconnectView = DisconnectView(frame: self.view.frame)
        self.view = disconnectView
    }
    // MARK: - Action Helper
    private func disconnectViewActions() {
        disconnectView.askDisconnectAlertView.cancelButtonTapCompletion = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        disconnectView.askDisconnectAlertView.okButtonTapCompletion = { [weak self] in
            guard let self = self else { return }
            self.coupleRepository.disconnectCouple { dataModel in
                if let dataModel = dataModel {
                    // 실패 경우
                    print(dataModel)
                } else {
                    UserDefaultsManager.shared.delete(.partnerId)
                    UserDefaultsManager.shared.delete(.userId)
                    UserDefaultsManager.shared.delete(.lastRoundId)
                    UserDefaultsManager.shared.delete(.hasCoupleCode)
                    let navigationViewController = UINavigationController(rootViewController: LoginViewController())
                    self.changeRootViewController(navigationViewController)
                }
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
