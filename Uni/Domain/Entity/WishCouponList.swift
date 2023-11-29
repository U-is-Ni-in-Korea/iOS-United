import Foundation

struct WishCouponList: Codable {
    let id: Int?
    let image, content: String?
    let isVisible, isUsed: Bool?
    let usedAt: String?
    let gameType: String?
}
