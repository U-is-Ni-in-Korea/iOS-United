import Foundation
import Combine

protocol BattleHistoryResultRepositoryInterface {
    func data() -> AnyPublisher<[BattleHistoryResultDTO], ErrorType>
}
