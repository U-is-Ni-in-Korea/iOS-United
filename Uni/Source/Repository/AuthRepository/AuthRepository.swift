import Foundation
import Alamofire

class AuthRepository {
    
    func postToken(socialType: String, token: String, completion: @escaping ((KakaoLoginDataModel) -> Void)) {
        let params: Parameters = [
            "code": "\(token)"
        ]
        print("?????????????")
        PostServiceDeprecated.shared.postService(with: params, isUseHeader: false, from: Config.baseURL + "auth/\(socialType)", callback: {
            (data: KakaoLoginDataModel?, error: String?) in
            if let error = error {
                print(error.description)
                print("실패")
            }
            else if let data = data {
                completion(data)
                print("성공", data, "데이터")
                
            }
        })
    }
}
