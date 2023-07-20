//
//  HistoryRepository.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/19.
//

import Foundation
import Alamofire

class HistoryRepository {
    func getHistoryData(completion: @escaping (([HistoryDataModel]) -> Void)) {
        GetService.shared.getService(from: Config.baseURL + "api/history", isUseHeader: true) { (data: [HistoryDataModel]?, error) in
            guard let data = data else {
                print("error")
                return
            }
            completion(data)
        }
    }
}
