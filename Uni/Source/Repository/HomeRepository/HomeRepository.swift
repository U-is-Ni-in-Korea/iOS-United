import Foundation
import Alamofire

class HomeRepository {
    func test(completion: (() -> Void)) {
        completion()
    }
    
    func getHomeData(completion: @escaping ((HomeDataModel) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/home",
                                     isUseHeader: true) { (data: HomeDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
    
    func isAlreadyGameFinish(completion: @escaping ((Bool) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/home",
                                     isUseHeader: true) { (data: HomeDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            
            var flag = data.shortGame == nil ? false: true
            
            if flag != UserDefaultsManager.shared.loadBool(.isAlreadyFinish) {
                flag = true
            } else {
                flag = false
            }
            completion(flag)
        }
    }
}
