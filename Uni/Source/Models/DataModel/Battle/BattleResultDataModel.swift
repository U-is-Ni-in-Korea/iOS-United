import Foundation

struct BattleResultDataModel: Codable {
    let myRoundMission: RoundMission?
    let partnerRoundMission: RoundMission?
}

struct BattleResultErrorModel: Codable {
    let code: String
}
