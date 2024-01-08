import Foundation
import Domain

struct BattleHistoryItemViewData {
    let date: String
    let gameTitle: String
    let imagePath: URL?
    let result: String
    let battleHistoryItem: BattleHistoryResultDTO
    init(battleHistoryItem: BattleHistoryResultDTO) {
        self.battleHistoryItem = battleHistoryItem
        self.date = battleHistoryItem.date ?? ""
        self.gameTitle = battleHistoryItem.title ?? ""
        self.imagePath = URL(string: battleHistoryItem.image ?? "")
        switch battleHistoryItem.result {
        case "DRAW":
            self.result = "무승부"
        case "WIN":
            self.result = "승리"
        case "LOSE":
            self.result = "패배"
        default:
            self.result = battleHistoryItem.result ?? ""
        }
    }
}
