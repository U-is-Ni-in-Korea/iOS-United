//
//  WishCouponDataModel.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/20.
//

import Foundation

struct WishCouponDataModel: Codable {
    let availableWishCoupon: Int?
    let newWishCoupon: Int?
    let wishCouponList: [WishCouponList?]
}
