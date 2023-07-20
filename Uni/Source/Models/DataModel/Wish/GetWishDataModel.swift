import Foundation

struct GetWishDataModel: Codable {
    let isMine: Bool
    let nickname: String
    let wishCoupon: WishCoupon
}
