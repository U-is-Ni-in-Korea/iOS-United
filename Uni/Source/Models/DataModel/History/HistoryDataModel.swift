//
//  HistoryDataModel.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/19.
//

import Foundation

struct HistoryDataModel: Codable {
    let roundGameId: Int?
    let date: String?
    let result: String?
    let title: String?
    let image: String?
    let winner: String?
    let myMission: MyMission
    let partnerMission: PartnerMission
}

struct MyMission: Codable {
    let content: String?
    let result: String?
    let time: String?
}

struct PartnerMission: Codable {
    let content: String?
    let result: String?
    let time: String?
}
