import Foundation

struct MyRoundMission: Codable {
    let id: Int
    let missionContent: MissionContent
    let updatedAt: String?
    let result, finalResult: String
}
