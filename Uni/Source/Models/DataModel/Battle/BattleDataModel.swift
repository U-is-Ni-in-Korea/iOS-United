import Foundation

struct BattleDataModel: Codable {
    let id: Int
    let title, description: String
    let rule: String
    let tip, image: String
    let missionContentList: [MissionContentList]
}
