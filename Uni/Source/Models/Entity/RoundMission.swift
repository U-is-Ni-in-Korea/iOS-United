import Foundation

struct RoundMission: Codable {
    let id: Int
    let missionContent: MissionContent
    let result: String?
    let finalResult: String
    let updatedAt: String?
}
