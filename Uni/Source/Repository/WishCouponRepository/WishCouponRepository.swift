//
//  WishCouponRepository.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/20.
//

import Foundation
import Alamofire

class WishCouponRepository {
    func getWishCouponData(userId: Int, completion: @escaping ((WishCouponDataModel) -> Void)) {
        GetServiceDeprecated.shared.getService(from: Config.baseURL + "api/user/\(userId)/wish",
                                     isUseHeader: true) { (data: WishCouponDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
}
