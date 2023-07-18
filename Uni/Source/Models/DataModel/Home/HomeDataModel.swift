import Foundation

struct HomeDataModel: Codable {
    let userID, roundGameID, myScore, partnerScore: Int
    let drawCount, dDay: Int
    let couple: Couple
    let shortGame: ShortGame?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case roundGameID = "roundGameId"
        case myScore, partnerScore, drawCount, dDay, couple, shortGame
    }
}
