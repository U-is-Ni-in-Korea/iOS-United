import Foundation
import Alamofire

final class WishRepository {
    
    func makeWishCoupon(content: String,
                        completion: @escaping ((ErrorCode?) -> Void)) {
        let params: Parameters = ["gameType": "SHORT",
                                  "content": content]
        PatchService.shared.patchService(with: params,
                                         isUseHeader: true,
                                         from: Config.baseURL + "api/wish") { (data: ErrorCode?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
    
    func getWishCouponDetail(wishId: Int,
                             completion: @escaping ((GetWishDataModel) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/wish/\(wishId)",
                                     isUseHeader: true) { (data: GetWishDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
    
    func useWishCoupon(wishId: Int,
                       completion: @escaping ((ErrorCode) -> Void)) {
        PatchService.shared.patchService(isUseHeader: true,
                                         from: Config.baseURL + "api/wish/\(wishId)") { (data: ErrorCode?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
    
    
}
