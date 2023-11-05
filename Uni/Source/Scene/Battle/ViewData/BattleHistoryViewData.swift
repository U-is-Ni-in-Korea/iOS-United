import Combine

protocol NavigationBarProtocol: ObservableObject {
    var dismissButtonTapPublisher: PassthroughSubject<Void, Never> { get set }
}

class BattleHistoryViewData: ObservableObject, NavigationBarProtocol {
    var dismissButtonTapPublisher = PassthroughSubject<Void, Never>()
    @Published var rountBattle: RoundBattleDataModel?
    let missionCompleteButtonTapPublisher = PassthroughSubject<Void, Never>()
    let missionFailureButtonTapPublisher = PassthroughSubject<Void, Never>()
}
