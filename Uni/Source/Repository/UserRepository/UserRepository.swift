//
//  UserRepository.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/19.
//

import Foundation
import Alamofire

class UserRepository {
    func patchUser(nickname: String, completion: @escaping ((Bool) -> Void)) {
        let params: Parameters = [
            "nickname": "\(nickname)"
        ]
        PatchService.shared.patchService(with: params, isUseHeader: true, from: Config.baseURL + "api/user", callback: { (data: UserDataModel?, error: String?) in
            if let error = error {
                print(error.description)
                print("실패")
                completion(false)
            }
            else if let data = data {
                print("성공")
                print(data)
                completion(true)
            }
        })
    }
    
    func patchUserProfile(nickname: String, startDate: String, completion: @escaping((Bool) -> Void)) {
        let params: Parameters = [
            "nickname" : "\(nickname)",
            "startDate": "\(startDate)"
        ]
        PatchService.shared.patchMultipartService(with: params,
                                                  from: Config.baseURL + "api/user/info",
                                                  callback: { (data: UserDataModel?, error: String?) in
            if let error = error {
                print(error.description)
                print("실패")
                completion(false)
            }
            else if let data = data {
                print("성공")
                print(data)
                completion(true)
            }
        })
    }
    
    func getUserData(completion: @escaping((UserDataModel) -> Void)) { GetServiceDeprecated.shared.getService(from: Config.baseURL + "api/user", isUseHeader: true) { (data: UserDataModel?, error) in
        guard let data = data else {
            print("error: \(error?.debugDescription)")
            return
        }
        completion(data)
    }
    }
    
    func deleteUserData(completion: @escaping((DeleteUserDataModel) -> Void)) {
        let param = ["userId": UserDefaultsManager.shared.load(.userId)]
        DeleteService.shared.deleteService(with: param,
                                           from: Config.baseURL + "api/user",
                                           isUseHeader: true) { (data: DeleteUserDataModel?, error) in
            guard let data = data else {
                print("error: \(error?.debugDescription)")
                return
            }
            completion(data)
        }
    }
}
