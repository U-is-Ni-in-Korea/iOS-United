//
//  DDayRepository.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/20.
//

import Foundation
import Alamofire

class DDayRepository {
    
    func postDday(startDate: String, completion: @escaping ((DDayDataModel) -> Void)) {
        let params: Parameters = [
            "startDate": "\(startDate)"
        ]
        
        PostService.shared.postService(with: params, isUseHeader: true, from: Config.baseURL + "api/couple", callback: {
            (data: DDayDataModel?, error: String?) in
            if let error = error {
                print(error.description)
                print("실패")
            }
            else if let data = data {
                completion(data)
                print("성공")
                
            }
        })
    }
}
