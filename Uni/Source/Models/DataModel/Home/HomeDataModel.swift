import Foundation

struct HomeDataModel: Codable {
    let userID, myScore, partnerScore, partnerId: Int
    let roundGameId: Int?
    let drawCount, dDay: Int
    let couple: Couple
    let shortGame: ShortGame?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case roundGameId = "roundGameId"
        case myScore, partnerScore, drawCount, dDay, couple, shortGame, partnerId
    }
}
