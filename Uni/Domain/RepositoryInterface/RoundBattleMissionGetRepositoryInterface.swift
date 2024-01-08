import Foundation
import Combine
import NetworkPlatform

protocol RoundBattleMissionRepositoryInterface {
    func data(roundId: Int) -> AnyPublisher<RoundBattleMissionDTO, ErrorType>
}
