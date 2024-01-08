import Foundation
import Combine

public protocol BattleHistoryResultUseCaseProtocol {
    func execute() -> AnyPublisher<[BattleHistoryResultDTO], ErrorType>
}

public final class BattleHistoryResultUseCase: BattleHistoryResultUseCaseProtocol {
    private let battleHistoryResultRepository: BattleHistoryResultRepositoryInterface
    public init(battleHistoryResultRepository: BattleHistoryResultRepositoryInterface) {
        self.battleHistoryResultRepository = battleHistoryResultRepository
    }
    public func execute() -> AnyPublisher<[BattleHistoryResultDTO], ErrorType> {
        return self.battleHistoryResultRepository.data()
    }
}
