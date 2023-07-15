import Foundation
import Alamofire
import Sentry

class GetService {
    static let shared = GetService()
    private init() {}
    
    private let tokenUtils = HeaderUtils()
    func getService <T: Decodable> (from url: String,
                                    isUseHeader: Bool,
                                     callback: @escaping (_ data: T?, _ error: String?) -> ()) {
                                   AF.request(url,
                                     method: .get,
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
                SentrySDK.capture(error: error)
                callback(nil, error.localizedDescription)
            }
        }
    }
    
}
