import Foundation

struct MakeBattleDataModel: Codable {
    let shortGame: ShortGame
    let roundGameID: Int
    let roundMission: RoundMission

    enum CodingKeys: String, CodingKey {
        case shortGame
        case roundGameID = "roundGameId"
        case roundMission
    }
}
