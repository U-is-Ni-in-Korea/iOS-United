import Combine
import Foundation
import Domain

struct BattleHistoryDetailViewModel {
    struct Input {
        let viewLoad: AnyPublisher<BattleHistoryResultDTO, Never>
    }
    struct Output {
        let historyDetailData: AnyPublisher<BattleHistoryDetailItemViewData, Never>
    }
    func transform(input: Input) -> Output {
        let historyData = input.viewLoad.map {
            return BattleHistoryDetailItemViewData(battleHistoryItem: $0)
        }.eraseToAnyPublisher()
        return Output(historyDetailData: historyData)
    }
}
