import Foundation
import Combine
import Domain
import NetworkPlatform

protocol BattleHistoryResultUseCaseProtocol {
    func execute() -> AnyPublisher<[BattleHistoryResultDTO], ErrorType>
}

final class BattleHistoryResultUseCase: BattleHistoryResultUseCaseProtocol {
    private let battleHistoryResultRepository: BattleHistoryResultRepositoryInterface
    init(battleHistoryResultRepository: BattleHistoryResultRepositoryInterface) {
        self.battleHistoryResultRepository = battleHistoryResultRepository
    }
    func execute() -> AnyPublisher<[BattleHistoryResultDTO], ErrorType> {
        return self.battleHistoryResultRepository.data()
    }
}
