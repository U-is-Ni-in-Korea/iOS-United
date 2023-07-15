import Foundation

struct MissionCategory: Codable {
    let id: Int
    let title, description, tip, image: String
    let level, expectedTime: Int
    let missionType: String
}
