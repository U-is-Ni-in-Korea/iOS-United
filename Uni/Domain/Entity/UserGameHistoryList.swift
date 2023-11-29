import Foundation

struct UserGameHistoryList: Codable {
    let id: Int
    let game: Game
    let updatedAt: String?
    let result, gameType: String
    let roundGameList: [RoundGameList]
}
