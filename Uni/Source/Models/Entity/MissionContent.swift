import Foundation

struct MissionContent: Codable {
    let id: Int
    let missionCategory: MissionCategory
    let content: String
}
