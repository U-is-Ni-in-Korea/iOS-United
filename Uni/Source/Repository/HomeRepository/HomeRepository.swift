import Foundation
import Alamofire

class HomeRepository {
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
    
    func isWriteGameState(roundGameId: Int,
                          completion: @escaping ((Bool) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/game/short/\(roundGameId)",
                                     isUseHeader: true) { (data: RoundBattleDataModel?, error) in
            if data?.myRoundMission.result == "UNDECIDED" {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
}
