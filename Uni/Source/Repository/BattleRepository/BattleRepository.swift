import Foundation
import Alamofire

class BattleRepository {
    func getGameList(completion: @escaping (([BattleDataModel]) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/mission",
                                     isUseHeader: true) { (data: [BattleDataModel]?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
    
    func getGameDetail(battleId: Int,
                       completion: @escaping ((BattleDataModel) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/mission/\(battleId)",
                                     isUseHeader: true) { (data: BattleDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
    
    func makeGame(missionId: Int,
                  wishContent: String,
                  completion: @escaping ((MakeBattleDataModel) -> Void)) {
        let params: Parameters = ["missionCategoryId": missionId,
                                  "wishContent": wishContent]
        PostService.shared.postService(with: params,
                                       isUseHeader: true,
                                       from: Config.baseURL + "api/game/short") { (data: MakeBattleDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
    
    func getRoundGameData(roundId: Int,
                          completion: @escaping ((RoundBattleDataModel) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/game/short/\(roundId)",
                                     isUseHeader: true) { (data: RoundBattleDataModel?,
                                                                  error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
    
    func patchRoundGameData(state: Bool,
                            roundId: Int,
                            completion: @escaping ((RoundBattleDataModel) -> Void)) {
        let param: Parameters = ["result": state]
        PatchService.shared.patchService(with: param,
                                         isUseHeader: true,
                                         from: Config.baseURL + "api/game/short/\(roundId)") { (data: RoundBattleDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
    
    func deleteRoundGameData(roundId: Int, completion: @escaping ((ErrorCode?) -> Void)) {
        DeleteService.shared.deleteService(from: Config.baseURL + "api/game/short/\(roundId)",
                                           isUseHeader: true) { (data: ErrorCode? ,error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
