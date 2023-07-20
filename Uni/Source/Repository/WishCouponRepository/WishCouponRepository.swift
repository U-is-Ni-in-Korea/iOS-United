//
//  WishCouponRepository.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/20.
//

import Foundation
import Alamofire

class WishCouponRepository {
    func getWishCouponData(completion: @escaping ((WishCouponDataModel) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/user/\(4)/wish",
                                     isUseHeader: true) { (data: WishCouponDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
}
