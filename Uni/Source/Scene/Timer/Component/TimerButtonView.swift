import SwiftUI
import SDSKit

struct TimerButtonView: View {
    @ObservedObject var timerState: TimerData
    var body: some View {
        HStack {
            Button {
                timerState.startTimer = false
                timerState.isTimerRunning = false
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(timerState.startTimer ? Color(uiColor: .gray000) : Color(uiColor: .gray300))
                        .shadow(color: Color(red: 0.06, green: 0.15, blue: 0.15).opacity(0.1), radius: 3, x: -1, y: 1)
                    Text("취소")
                        .foregroundColor(timerState.startTimer ? Color(uiColor: .gray400) : Color(uiColor: .gray000))
                }
                .frame(width: 80, height: 80)
            }
            .disabled(!timerState.startTimer)
            .background(timerState.startTimer ? Circle().foregroundColor(Color(uiColor: .gray000)) : Circle().foregroundColor(Color(uiColor: .gray300)))
            .foregroundColor(timerState.startTimer ? Color(uiColor: .gray400) : Color(uiColor: .gray000))
            Spacer()
            Button {
                if timerState.startTimer == false {
                    timerState.makeTime()
                    timerState.isTimerRunning = true
                    timerState.startTimer = true
                } else {
                    timerState.isTimerRunning.toggle()
                }
            } label: {
                if timerState.startTimer {
                    ZStack {
                        Circle()
                            .foregroundColor(timerState.isTimerRunning ?  Color(uiColor: .gray000) : Color(uiColor: .lightBlue500))
                            .shadow(color: Color(red: 0.06, green: 0.15, blue: 0.15).opacity(0.1), radius: 3, x: -1, y: 1)
                        Text(timerState.isTimerRunning ? "일시정지" : "재개")
                            .foregroundColor(timerState.isTimerRunning ? Color(uiColor: .lightBlue600) : Color(uiColor: .gray000))
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
