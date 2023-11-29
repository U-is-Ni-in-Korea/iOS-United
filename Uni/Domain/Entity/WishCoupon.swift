import Foundation

struct WishCoupon: Codable {
    let id: Int
    let image: String?
    let content: String
    let isVisible, isUsed: Bool
    let usedAt: String?
    let gameType: String
}
