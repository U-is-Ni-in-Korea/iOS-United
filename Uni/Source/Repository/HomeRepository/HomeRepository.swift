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
            
            if let roundId = data.roundGameId {
                //기존 게임과 현재 게임이 동일한 경우
                if roundId == UserDefaultsManager.shared.loadInt(.lastRoundId) {
                    completion(false)
                } else {
                    /**둘이 다른 경우
                     기존에 진행하던 게임이 종료되어 버린 경우*/
                    UserDefaultsManager.shared.save(value: roundId, forkey: .lastRoundId)
                    completion(true)
                }
            } else {
                //라운드가 아예 없는 경우
                completion(false)
            }
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
