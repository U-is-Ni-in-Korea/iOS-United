//
//  HistoryStatus.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/19.
//

import Foundation

//enum HistoryStatus {
//    case win
//    case lose
//    case draw
//}

enum HistoryStatus: String {
    case win = "WIN"
    case lose = "LOSE"
    case draw = "DRAW"
    
    func getStatus() -> String {
        switch self {
        case .win:
            return "미션 성공"
        case .draw:
            return "무승부"
        case .lose:
            return "미션 실패"
        }
    }
}
