import Combine

class BattleHistoryViewData: ObservableObject {
    @Published var rountBattle: RoundBattleDataModel?
    let dismissButtonTapPublisher = PassthroughSubject<Void, Never>()
    let missionCompleteButtonTapPublisher = PassthroughSubject<Void, Never>()
    let missionFailureButtonTapPublisher = PassthroughSubject<Void, Never>()
}
