import Foundation
import Alamofire

class BattleRepository {
    func getGameList(completion: @escaping ((BattleDataModel) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/mission",
                                     isUseHeader: true) { (data: BattleDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
}
