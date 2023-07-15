import Foundation

struct MyRoundMission: Codable {
    let id: Int
    let missionContent: MissionContent
    let updatedAt, result, finalResult: String
}
