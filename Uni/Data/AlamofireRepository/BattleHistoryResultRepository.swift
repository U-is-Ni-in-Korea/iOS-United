import Combine
import Foundation
import Domain
import NetworkPlatform

final class BattleHistoryResultRepository: BattleHistoryResultRepositoryInterface {
    private let service: GetServiceCombine
    init(service: GetServiceCombine) {
        self.service = service
    }
    func data() -> AnyPublisher<[BattleHistoryResultDTO], ErrorType> {
        self.service.getService(from: Config.baseURL + "api/history", isUseHeader: true)
    }
}
