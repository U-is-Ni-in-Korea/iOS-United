import Foundation
import Combine

public protocol BattleHistoryResultRepositoryInterface {
    func data() -> AnyPublisher<[BattleHistoryResultDTO], ErrorType>
}
