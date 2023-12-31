//
//  KakaoLoginDataModel.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/18.
//

import Foundation

struct KakaoLoginDataModel: Decodable {
    let accessToken: String?
    let refreshToken: String?
    let coupleId: Int?
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case coupleId = "couple_id"
    }
}

