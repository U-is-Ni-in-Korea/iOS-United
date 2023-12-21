import UIKit
import SDSKit
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let keyChains = HeaderUtils()
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        registerFonts()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        setScene(scene)
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let timerEnterBackgroundTime = UserDefaults.standard.object(forKey: "sceneDidEnterBackground") as? Date else { return }
        let timeInterval = Int(Date().timeIntervalSince(timerEnterBackgroundTime))
        guard let timerCount = UserDefaults.standard.object(forKey: "existingCountData") as? Int else { return }
        let remainTimerCount = timerCount - timeInterval
        NotificationCenter.default.post(name: NSNotification.Name("remainTimerTime"), object: nil, userInfo: ["time": timeInterval])
        UserDefaults.standard.removeObject(forKey: "sceneDidEnterBackground")
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name("sceneDidEnterBackground"), object: nil)
        UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
        if let navigationController = window?.rootViewController as? UINavigationController {
            if let homeViewController = navigationController.viewControllers.first as? HomeViewController {
                let timerCount = homeViewController.timerViewData.remainingTime
                if timerCount != 0 {
                    UserDefaults.standard.setValue(timerCount, forKey: "existingCountData")
                }
            }
        }
    }
}
extension SceneDelegate {
    private func setScene(_ scene: UIScene) {
        setRootViewController(scene, viewController: SplashViewController())
    }
    private func setRootViewController(_ scene: UIScene, viewController: UIViewController) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}
