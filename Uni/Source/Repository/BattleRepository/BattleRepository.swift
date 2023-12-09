import Foundation

import Alamofire

enum BattleResultError: String, Error {
    case disconnectCouple = "UE1006"
    case notFinish = "UE1009"
    case emptyData
    func errorResponse() -> String {
        switch self {
        case .notFinish:
            return "상대가 결과를 입력하기 전이에요"
        case .emptyData:
            return ""
        case .disconnectCouple:
            return ""
        }
    }
}

class BattleRepository {
    func getGameList(completion: @escaping ((Result<[BattleDataModel], BattleResultError>) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/mission",
                                     isUseHeader: true) { (data: [BattleDataModel]?, error) in
            if let data = data {
                completion(.success(data))
            } else {
                let errorCode = BattleResultError(rawValue: error ?? "") ?? .emptyData
                completion(.failure(errorCode))
            }
        }
    }
    func getGameDetail(battleId: Int,
                       completion: @escaping ((BattleDataModel) -> Void)) {
        GetServiceDeprecated.shared.getService(from: Config.baseURL + "api/mission/\(battleId)",
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
        GetServiceDeprecated.shared.getService(from: Config.baseURL + "api/game/short/\(roundId)",
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
    
    func getBattleResultData(roundId: Int, completion: @escaping ((Result<BattleResultDataModel?, BattleResultError>) -> Void)) {
        let tokenUtils = HeaderUtils()
        let url = Config.baseURL + "api/game/short/result/\(roundId)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: tokenUtils.getAuthorizationHeader()).response { response in
            guard let resData = response.data else { return }
            do {
                let successData = try? JSONDecoder().decode(BattleResultDataModel.self, from: resData)
                if let successData = successData {
                    print(successData, "?????코드아님")
                    completion(.success(successData))
                } else {
                    let data = try? JSONDecoder().decode(BattleResultErrorModel.self, from: resData)
                    if let data = data {
                        print(data.code, "코드")
                        let resultError = BattleResultError(rawValue: data.code) ?? .emptyData
                        completion(.failure(resultError))
                    }
                }
            }
            catch {
                completion(.failure(.emptyData))
            }
        }
    }
}
