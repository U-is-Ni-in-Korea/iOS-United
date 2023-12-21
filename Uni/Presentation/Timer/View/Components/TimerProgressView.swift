import SwiftUI
import SDSKit

struct TimerProgressView: View {
    // MARK: - Property
    let remainingTime: Int
    let totalTime: Int
    let isTimerRunning: Bool
    // MARK: - UI Property
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .foregroundColor(Color(uiColor: .gray150))
                    .frame(maxWidth: .infinity)
                Circle()
                    .foregroundColor(Color(uiColor: .gray000))
                    .frame(maxWidth: .infinity - 16)
            }
            Circle()
                .fill(Color(uiColor: .gray000))
                .frame(maxWidth: .infinity)
                .overlay(
                    Circle()
                        .trim(from: 0,
                              to: CGFloat(remainingTime)/CGFloat(totalTime)
                             )
                        .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round)
                        )
                        .foregroundColor(isTimerRunning ? Color(uiColor: .lightBlue500) : Color(uiColor: .gray150))
                )
                .rotationEffect(.degrees(-90))
            HStack {
                Text(String(format: "%02d", remainingTime/60))
                    .foregroundColor(Color(uiColor: .gray600))
                    .frame(width: 100)
                Text(" : ")
                    .foregroundColor(Color(uiColor: .gray600))
                Text(String(format: "%02d", remainingTime%60))
                    .foregroundColor(Color(uiColor: .gray600))
                    .frame(width: 100)
            }
            .font(.system(size: 68))
        }
        .frame(maxWidth: .infinity)
    }
}
