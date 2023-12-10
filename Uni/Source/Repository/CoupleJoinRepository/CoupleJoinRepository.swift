import Foundation

import Alamofire

enum CoupleJoinError: String, Error {
    case badRequest = "UE1001"
    case invalidCoupleCode = "UE1007"
    case emptyToken = "UE1002"
    case expiredToken = "UE2001"
    case invalidToken = "UE2002"
    case connectedCoupleCode = "UE10002"
    case serverError = "UE500"
    case unknown
    func errorResponse() -> String {
        switch self {
        case .badRequest:
            return "잘못된 요청입니다."
        case .invalidCoupleCode:
            return "입력하신 코드 정보를 찾을 수 없어요"
        case .emptyToken:
            return "다시 로그인을 해야 합니다."
        case .expiredToken:
            return "다시 로그인을 해야 합니다."
        case .invalidToken:
            return "다시 로그인을 해야 합니다."
        case .connectedCoupleCode:
            return "이미 사용중인 코드에요"
        case .serverError:
            return "현재 서버에 오류가 생겼습니다. 잠시 후 다시 시도해주세요"
        case .unknown:
            return "예기치 못한 에러입니다."
        }
    }
}

struct CoupleJoinRepository {
    static func getCoupleJoin(completion: @escaping ((Bool) -> Void)) {
        GetServiceDeprecated.shared.getService(from: Config.baseURL + "api/couple/join", isUseHeader: true) { (data: GetCoupleJoinDataModel?, error: String?) in
            if let error = error { print(error.description)
            } else if let data = data?.connection {
                completion(data)
            }
        }
    }
    static func postCoupleJoin(code: String, completion: @escaping ((Result<String, CoupleJoinError>) -> Void)) {
        let params: Parameters = [
            "inviteCode": code
        ]
        PostServiceDeprecated.shared.postService(with: params, isUseHeader: true, from: Config.baseURL + "api/couple/join") { (data: PostCoupleJoinDataModel?, _) in
            guard let code = data?.code else {
                    completion(.success("성공"))
                    return
                }
                let joinError = CoupleJoinError(rawValue: code) ?? .unknown
                switch joinError {
                case .badRequest, .invalidCoupleCode, .emptyToken, .expiredToken, .invalidToken, .connectedCoupleCode, .serverError:
                    completion(.failure(joinError))
                case .unknown:
                    completion(.failure(.unknown))
                }
        }
    }
    func disconnectCouple(completion: @escaping((DisConnectCoupleDataModel?) -> Void)) {
        DeleteService.shared.deleteService(from: Config.baseURL + "api/couple", isUseHeader: true) { (data: DisConnectCoupleDataModel?, error) in
            completion(data)
        }
    }
}


struct DisConnectCoupleDataModel: Codable {
    let code: String
}
