import Foundation

struct MissionCategory: Codable {
    let id: Int
    let title, description, tip: String
    let image: String?
    let level, expectedTime: Int
    let missionType: String
}
