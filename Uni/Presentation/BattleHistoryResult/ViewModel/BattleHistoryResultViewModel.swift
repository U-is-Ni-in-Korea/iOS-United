import Combine
import Foundation

struct BattleHistoryResultViewModel {
    private let battleHistoryResultUsecase: BattleHistoryResultUseCaseProtocol
    init(battleHistoryResultUsecase: BattleHistoryResultUseCaseProtocol) {
        self.battleHistoryResultUsecase = battleHistoryResultUsecase
    }
    struct Input {
        let viewLoad: AnyPublisher<Void, Never>
    }
    struct Output {
        let loadBattleHistoryResultData: AnyPublisher<[BattleHistoryResultDTO], ErrorType>
    }
    func transform(input: Input) -> Output {
        let historyData = input.viewLoad.flatMap {
            let data = self.battleHistoryResultUsecase.execute().delay(for: 3, scheduler: RunLoop.main)
            return data
        }.eraseToAnyPublisher()
        return Output(loadBattleHistoryResultData: historyData)
    }
}
