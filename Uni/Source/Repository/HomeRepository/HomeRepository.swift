import Foundation
import Alamofire

class HomeRepository {
    func test(completion: (() -> Void)) {
        completion()
    }
    
    func getHomeData(completion: @escaping ((HomeDataModel) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/home",
                                     isUseHeader: false) { (data: HomeDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
}
