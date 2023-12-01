import Combine

protocol NavigationBarProtocol: ObservableObject {
    var dismissButtonTapPublisher: PassthroughSubject<Void, Never> { get set }
}

class BattleHistoryViewData: ObservableObject, NavigationBarProtocol {
    var dismissButtonTapPublisher = PassthroughSubject<Void, Never>()
    @Published var rountBattle: RoundBattleDataModel?
    let missionCompleteButtonTapSubject = PassthroughSubject<Void, Never>()
    let missionFailureButtonTapSubject = PassthroughSubject<Void, Never>()
    let timerButtonTapSubejct = PassthroughSubject<Void, Never>()
    let memoButtonTapSubject = PassthroughSubject<Void, Never>()
}
