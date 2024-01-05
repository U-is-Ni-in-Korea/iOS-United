import Foundation

public struct BattleHistoryResultDTO: Codable {
    public let roundGameId: Int?
    public let date: String?
    public let result: String?
    public let title: String?
    public let image: String?
    public let winner: String?
    public let myMission: MyMission
    public let partnerMission: PartnerMission
}

public struct MyMission: Codable {
    public let content: String?
    public let result: String?
    public let time: String?
}

public struct PartnerMission: Codable {
    public let content: String?
    public let result: String?
    public let time: String?
}

extension BattleHistoryResultDTO: Equatable {
    public static func == (lhs: BattleHistoryResultDTO, rhs: BattleHistoryResultDTO) -> Bool {
        return lhs.roundGameId == rhs.roundGameId &&
            lhs.date == rhs.date &&
            lhs.result == rhs.result &&
            lhs.title == rhs.title &&
            lhs.image == rhs.image &&
            lhs.winner == rhs.winner &&
            lhs.myMission == rhs.myMission &&
            lhs.partnerMission == rhs.partnerMission
    }
}
extension MyMission: Equatable {}
extension PartnerMission: Equatable {}
