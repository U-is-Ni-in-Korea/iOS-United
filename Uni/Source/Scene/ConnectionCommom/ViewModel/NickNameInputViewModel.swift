import SwiftUI
import Combine

enum NickNameInputState {
    case _default
    case satisfied
    case lengthOver
}

final class NickNameInputViewModel: ObservableObject {
    private var navigationController: UINavigationController
    private let userRepository = UserRepository()
    private let keyChains = HeaderUtils()
    
    @Published var state: NickNameInputState = ._default
    @Published var stateColor: Color = Color(uiColor: .gray200)
    @Published var nickName: String = ""
    @Published var nickNameLenght: Int = 0
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setCurrentState() {
        $nickNameLenght
            .sink(receiveValue: { [weak self] value in
                guard let self else {return}
                if value > 0 && value <= 5 {
                    self.state = .satisfied
                }
                else if value == 0 {
                    self.state = ._default
                } else {
                    self.state = .lengthOver
                }
                print(value)
            })
            .cancel()
        
        $state
            .sink(receiveValue: { [weak self] state in
                guard let self else {return}
                switch state {
                case ._default:
                    self.stateColor = Color(uiColor: .gray200)
                case .satisfied:
                    self.stateColor = Color(uiColor: .lightBlue500)
                case .lengthOver:
                    self.stateColor = Color(uiColor: .red500)
                }
            })
            .cancel()
    }
    func pop() {
        self.navigationController.popViewController(animated: true)
    }
    
    func pushToQnAView() {
        let qnaVC = QnAViewController()
        self.navigationController.pushViewController(qnaVC, animated: true)
    }
    
    func showLogOutAlert() {
        let alretView = self.navigationController.visibleViewController?.view.showAlert(title: "로그아웃 하시겠습니까?",
                                                                                        message: "",
                                                                                        cancelButtonMessage: "취소",
                                                                                        okButtonMessage: "로그아웃",
                                                                                        type: .alert)
        alretView?.okButtonTapCompletion = { [weak self] in
            guard let self else {return}
            if self.keyChains.isTokenExists(account: "accessToken") {
                self.keyChains.delete("accessToken")
                UserDefaultsManager.shared.delete(.hasOnboarded)
                UserDefaultsManager.shared.delete(.isAlreadyFinish)
                UserDefaultsManager.shared.delete(.lastRoundId)
                UserDefaultsManager.shared.delete(.userId)
                UserDefaultsManager.shared.delete(.partnerId)
                let loginViewController = LoginViewController()
                self.changeRootViewController(UINavigationController(rootViewController: loginViewController))
            }
        }
        
        alretView?.cancelButtonTapCompletion = { [weak self] in
            guard let self else {return}
            self.navigationController.visibleViewController?.view.hideAlert(view: alretView!)
        }
    }
    
    func nextButtonTap() {
        if self.nickName.count > 0 && self.nickName.count <= 5 {
            self.navigationController.visibleViewController?.view.showIndicator()
            userRepository.patchUser(nickname: self.nickName) { response in
                if response {
                    print("성공!")
                    self.navigationController.visibleViewController?.view.removeIndicator()
                    let coupleConnectionMethodViewController = CoupleConnectionMethodViewController()
                    self.navigationController.pushViewController(coupleConnectionMethodViewController, animated: true)
                }
                else {
                    print("실패")
                    self.navigationController.visibleViewController?.view.removeIndicator()
                }
            }
        }
    }
    
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.navigationController.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
}
