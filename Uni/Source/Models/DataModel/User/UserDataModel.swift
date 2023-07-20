//
//  UserDataModel.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/19.
//

import Foundation

struct UserDataModel: Codable {
    let id: Int?
    let nickname: String?
    let image: String?
    let startDate: String?
    let couple: Couple?
}
