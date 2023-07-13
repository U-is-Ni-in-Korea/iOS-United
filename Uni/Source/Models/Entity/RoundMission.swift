import Foundation

struct RoundMission: Codable {
    let roundMissionID: Int
    let missionContent: MissionContent
    let result, finalResult: String
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case roundMissionID = "roundMissionId"
        case missionContent, result, finalResult, updatedAt
    }
}
