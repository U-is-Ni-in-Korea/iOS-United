import Foundation
import Combine
import Domain
import NetworkPlatform

protocol BattleHistoryResultRepositoryInterface {
    func data() -> AnyPublisher<[BattleHistoryResultDTO], ErrorType>
}
