import Combine

class BattleMemoViewData: ObservableObject, NavigationBarProtocol {
    var dismissButtonTapPublisher = PassthroughSubject<Void, Never>()
}
