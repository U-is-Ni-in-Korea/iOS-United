//
//  CoupleJoinRepository.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/20.
//

import Foundation
import Alamofire

class CoupleJoinRepository {
    func getCoupleJoin(completion: @escaping ((Bool) -> Void)) {
        
        GetService.shared.getService(from: Config.baseURL + "api/couple/join", isUseHeader: true) { (data: GetCoupleJoinDataModel?, error: String?) in
            if let error = error {
                print(error.description)
            }
            else if let data = data?.connection {
                completion(data)
            }
        }
    }
    
    func postCoupleJoin(code: String, completion: @escaping ((String?) -> Void)) {
        
        let params: Parameters = [
            "inviteCode": code
        ]
        
        PostService.shared.postService(with: params, isUseHeader: true, from: Config.baseURL + "api/couple/join") { (data: PostCoupleJoinDataModel?, error) in
            print(data, "데이터")
            print(error, "에러")

            completion(data?.code)
            
        }
    }
}
