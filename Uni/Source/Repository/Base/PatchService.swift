import Foundation
import Alamofire

class PatchService {
    static let shared = PatchService()
    private init() {}
    
    private let tokenUtils = HeaderUtils()
    func patchService <T: Decodable> (with param: Parameters? = nil,
                                      isUseHeader: Bool,
                                      from url: String,
                                      callback: @escaping (_ data: T?, _ error: String?) -> ()) {
                                   AF.request(url,
                                     method: .patch,
                                     parameters: param,
                                     encoding: JSONEncoding.default,
                                     headers: isUseHeader ? tokenUtils.getAuthorizationHeader(): tokenUtils.getNormalHeader()).response { response in

            do {
                print("\n\n 😎 ErrorCode is : \(response.response?.statusCode)\n\n")
                guard let resData = response.data else {
                    callback(nil, "emptyData")
                    return
                }
                let data = try JSONDecoder().decode(T.self, from: resData)
                callback(data, nil)
            } catch {
                callback(nil, error.localizedDescription)
            }
        }
    }
}
