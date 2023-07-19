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
}
