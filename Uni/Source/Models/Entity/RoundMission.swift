import Foundation

struct RoundMission: Codable {
    let id: Int
    let missionContent: MissionContent
    let result, finalResult: String
    let updatedAt: String?
}
