import Foundation

struct UserGameHistoryList: Codable {
    let id: Int
    let game: Game
    let result, updatedAt, gameType: String
    let roundGameList: [RoundGameList]
}
