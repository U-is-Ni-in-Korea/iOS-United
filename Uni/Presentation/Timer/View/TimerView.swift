import SwiftUI
import SDSKit

struct TimerView: View {
    // MARK: - Property
    @State private var alertIsShown = false
    @State private var backButtonTapped: Bool = false
    @State private var exitButtonTapped: Bool = false
    @State private var isTimerRunning: Bool = false
    @State private var makeTimeTrigger: Bool = false
    @ObservedObject var timerData: TimerData
    @ObservedObject var timerViewData: TimerViewData
    // MARK: - UI Property
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                BattleTimerNavigaionView(label: "타이머") {
                    alertIsShown = true
                }
                if timerData.startTimer {
                    TimerProgressView(remainingTime: timerData.remainingTime, totalTime: timerData.totalTime, isTimerRunning: timerData.isTimerRunning)
                        .padding(.horizontal, 24)
                        .padding(.top, 32)
                } else {
                    TimerPickerView(selectedMinute: $timerData.selectedMinute, selectedSecond: $timerData.selectedSecond)
                        .frame(height: UIScreen.main.bounds.size.width - 48)
                        .padding(.horizontal, 24)
                        .padding(.top, 32)
                        .pickerStyle(WheelPickerStyle())
                }
                TimerButtonView(startTimer: $timerData.startTimer, isTimerRunning: $timerData.isTimerRunning, makeTimeTrigger: $makeTimeTrigger)
                    .padding(.horizontal, 16)
                TimerTipView()
                    .opacity(timerData.startTimer ? 0 : 1.0)
                    .padding(.top, 32)
                    .padding(.horizontal, 16)
                Spacer()
            }
            if timerData.endTimerAlert {
                VStack {
                    Spacer()
                    TimerToastView()
                        .padding(.top, 61)
                }
            }
            if alertIsShown {
                BattleTimerAlertView(cancelButtonTapped: $alertIsShown, exitButtonTapped: $exitButtonTapped)
            }
        }
        .background(Color(uiColor: .gray100))
        // MARK: - Life Cycle
        .onChange(of: makeTimeTrigger, perform: { _ in
            timerData.makeTime()
        })
        .onChange(of: backButtonTapped) { _ in
            alertIsShown.toggle()
        }
        .onChange(of: exitButtonTapped) { _ in
            timerViewData.popButtonTapPublisher.send()
        }
        .onChange(of: timerData.endTimerAlert) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                timerData.hideEndTimerAlert()
            }
        }
    }
}
