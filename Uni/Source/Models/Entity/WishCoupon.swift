struct WishCoupon: Codable {
    let id: Int
    let image, content: String
    let isVisible, isUsed: Bool
    let usedAt, gameType: String
}
