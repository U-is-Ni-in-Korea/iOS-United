import Combine

protocol NavigationBarProtocol: ObservableObject {
    var dismissButtonTapPublisher: PassthroughSubject<Void, Never> { get set }
}

class BattleProgressViewModel: ObservableObject, NavigationBarProtocol {
    @Published var rountBattle: RoundBattleDataModel?
    private let roundBattleMissionUseCase: RoundBattleMissionUseCaseProtocol
    init(roundBattleMissionUseCase: RoundBattleMissionUseCaseProtocol) {
        self.roundBattleMissionUseCase = roundBattleMissionUseCase
    }
    
    
    var dismissButtonTapPublisher = PassthroughSubject<Void, Never>()
    let missionCompleteButtonTapSubject = PassthroughSubject<Void, Never>()
    let missionFailureButtonTapSubject = PassthroughSubject<Void, Never>()
    let timerButtonTapSubejct = PassthroughSubject<Void, Never>()
    let memoButtonTapSubject = PassthroughSubject<Void, Never>()
    private var cancellables: Set<AnyCancellable> = []
    
    func getRoundBattleData(roundId: Int) {
        roundBattleMissionUseCase.execute(roundId: roundId).sink { completion in
            print(completion)
        } receiveValue: { data in
            print(data)
        }.store(in: &cancellables)

    }
}
