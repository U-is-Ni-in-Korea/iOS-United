import Foundation

struct BattleHistoryDetailItemViewData {
    let date: String
    let gameTitle: String
    let gameResult: String
    let imagePath: URL?
    let myMissionTitle: String
    let myMisstionResult: String
    let myMisstionStatus: HistoryStatus
    let partnerMissionTitle: String
    let partnerMisstionResult: String
    let partnerStatus: HistoryStatus
    let battleHistoryItem: BattleHistoryResultDTO
    init(battleHistoryItem: BattleHistoryResultDTO) {
        self.battleHistoryItem = battleHistoryItem
        self.date = battleHistoryItem.date ?? ""
        self.gameTitle = battleHistoryItem.title ?? ""
        self.imagePath = URL(string: battleHistoryItem.image ?? "")
        self.myMissionTitle = battleHistoryItem.myMission.content ?? ""
        self.partnerMissionTitle = battleHistoryItem.partnerMission.content ?? ""
        switch battleHistoryItem.myMission.result {
        case "WIN":
            self.myMisstionResult = (battleHistoryItem.myMission.time ?? "") + " 미션 성공"
            self.myMisstionStatus = .win
        case "LOSE":
            self.myMisstionResult = "미션 실패"
            self.myMisstionStatus = .lose
        default:
            self.myMisstionResult = ""
            self.myMisstionStatus = .draw
        }
        switch battleHistoryItem.partnerMission.result {
        case "WIN":
            self.partnerMisstionResult = (battleHistoryItem.partnerMission.time ?? "") + " 미션 성공"
            self.partnerStatus = .win
        case "LOSE":
            self.partnerMisstionResult = "미션 실패"
            self.partnerStatus = .lose
        default:
            self.partnerMisstionResult = ""
            self.partnerStatus = .draw
        }
        if (battleHistoryItem.winner ?? "").isEmpty {
            self.gameResult = "무승부예요"
        } else {
            self.gameResult = "\(battleHistoryItem.winner ?? "")님이 이겼어요"
        }
    }
}
