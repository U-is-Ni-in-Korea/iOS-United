import Foundation
import Combine
import Domain
import NetworkPlatform

protocol RoundBattleMissionRepositoryInterface {
    func data(roundId: Int) -> AnyPublisher<RoundBattleMissionDTO, ErrorType>
}
