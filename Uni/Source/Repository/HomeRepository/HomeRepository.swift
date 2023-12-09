import Foundation
import Alamofire

enum HomeError: String, Error {
    case disconnectCouple = "UE1006"
    case unknown
}

class HomeRepository {
    func getHomeData(completion: @escaping ((Result<HomeDataModel, HomeError>) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/home",
                                     isUseHeader: true) { (data: HomeDataModel?, error) in
            if let data = data {
                completion(.success(data))
            } else {
                let errorCode = HomeError(rawValue: error ?? "") ?? .unknown
                completion(.failure(errorCode))
            }
        }
    }
    func isWriteGameState(roundGameId: Int,
                          completion: @escaping ((Result<Bool, HomeError>) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/game/short/\(roundGameId)",
                                               isUseHeader: true) { (data: RoundBattleDataModel?, error) in
            if let data = data {
                if data.myRoundMission?.result == "UNDECIDED" {
                    completion(.success(false))
                } else {
                    completion(.success(true))
                }
            } else {
                let errorCode = HomeError(rawValue: error ?? "") ?? .unknown
                completion(.failure(errorCode))
            }
        }
    }
}
