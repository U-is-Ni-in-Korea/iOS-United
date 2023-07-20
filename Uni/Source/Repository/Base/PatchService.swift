import Foundation
import Alamofire
import UIKit

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
                dump(response)
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
    
    
    func patchMultipartService <T: Decodable> (with param: Parameters? = nil,
                                      from url: String,
                                      callback: @escaping (_ data: T?, _ error: String?) -> ()) {
        let headerUtil = HeaderUtils()
        let authToken = headerUtil.read(account: "accessToken") ?? ""
        let header: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer \(authToken)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            if let params = param {
                for (key, value) in params {
                    print(key, value)
                    multipartFormData.append("\(value)".data(using: .utf8)!,
                                             withName: key)
                }
//                if let imageData = UIImage(named: "logo")?.pngData() {
//                    multipartFormData.append(imageData.base64EncodedString(),
//                                             withName: "image")
//                }
            }
        },
                  to: url,
                  method: .patch,
                  headers: header).response { response in
            do {
                dump(response)
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
