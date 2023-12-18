import SwiftUI
import SDSKit

struct TimerButtonView: View {
    // MARK: - Property
    @Binding var startTimer: Bool
    @Binding var isTimerRunning: Bool
    @Binding var makeTimeTrigger: Bool
    // MARK: - UI Property
    var body: some View {
        HStack {
            Button {
                startTimer = false
                isTimerRunning = false
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(startTimer ? Color(uiColor: .gray000) : Color(uiColor: .gray300))
                        .shadow(color: Color(red: 0.06, green: 0.15, blue: 0.15).opacity(0.1), radius: 3, x: -1, y: 1)
                    Text("취소")
                        .foregroundColor(startTimer ? Color(uiColor: .gray400) : Color(uiColor: .gray000))
                }
                .frame(width: 80, height: 80)
            }
            .disabled(!startTimer)
            .background(startTimer ? Circle().foregroundColor(Color(uiColor: .gray000)) : Circle().foregroundColor(Color(uiColor: .gray300)))
            .foregroundColor(startTimer ? Color(uiColor: .gray400) : Color(uiColor: .gray000))
            Spacer()
            Button {
                if startTimer == false {
                    makeTimeTrigger.toggle()
                    isTimerRunning = true
                    startTimer = true
                } else {
                    isTimerRunning.toggle()
                }
            } label: {
                if startTimer {
                    ZStack {
                        Circle()
                            .foregroundColor(isTimerRunning ?  Color(uiColor: .gray000) : Color(uiColor: .lightBlue500))
                            .shadow(color: Color(red: 0.06, green: 0.15, blue: 0.15).opacity(0.1), radius: 3, x: -1, y: 1)
                        Text(isTimerRunning ? "일시정지" : "재개")
                            .foregroundColor(isTimerRunning ? Color(uiColor: .lightBlue600) : Color(uiColor: .gray000))
                    }
                    .frame(width: 80, height: 80)
                } else {
                    ZStack {
                        Circle()
                            .foregroundColor(Color(uiColor: .lightBlue500))
                            .shadow(color: Color(red: 0.06, green: 0.15, blue: 0.15).opacity(0.1), radius: 3, x: -1, y: 1)
                        Text("시작")
                            .foregroundColor(Color(uiColor: .gray000))
                    }
                    .frame(width: 80, height: 80)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .font(Font(SDSFont.body1.font))
    }
}
