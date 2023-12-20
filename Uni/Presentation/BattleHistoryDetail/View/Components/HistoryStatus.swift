import Foundation

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
    func getStatusT() -> String {
        switch self {
        case .win:
            return "승리"
        case .draw:
            return "무승부"
        case .lose:
            return "패배"
        }
    }
}
