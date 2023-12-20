import Foundation

struct BattleHistoryResultDTO: Codable {
    let roundGameId: Int?
    let date: String?
    let result: String?
    let title: String?
    let image: String?
    let winner: String?
    let myMission: MyMission
    let partnerMission: PartnerMission
}

struct MyMission: Codable {
    let content: String?
    let result: String?
    let time: String?
}

struct PartnerMission: Codable {
    let content: String?
    let result: String?
    let time: String?
}
