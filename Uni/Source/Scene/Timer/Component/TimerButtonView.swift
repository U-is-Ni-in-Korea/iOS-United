//
//  TimerButtonView.swift
//  Uni
//
//  Created by 홍유정 on 2023/09/30.
//

import SwiftUI
import SDSKit

struct TimerButtonView: View {

    @EnvironmentObject var timerState: TimerState

    var body: some View {
        HStack {
            Button {
                if timerState.isTimerRunning {
                    
                }
                timerState.startTimer = false
            } label: {
                Text("취소")
            }
            .disabled(!timerState.startTimer)
            .frame(width: 80, height: 80)
            .background(timerState.startTimer ? Circle().foregroundColor(Color(uiColor: .gray000)) : Circle().foregroundColor(Color(uiColor: .gray300)))
            .foregroundColor(timerState.startTimer ? Color(uiColor: .gray400) : Color(uiColor: .gray000))
            .clipShape(Circle())

            Spacer()

            Button {
                if timerState.startTimer == false {
                    timerState.timeRemaining = timerState.selectedMinute * 60 + timerState.selectedSecond
                    timerState.totalSeconds = timerState.selectedMinute * 60 + timerState.selectedSecond
                    timerState.isTimerRunning = true
                    timerState.startTimer.toggle()
                } else {
                    timerState.isTimerRunning.toggle()
                }
            } label: {
                if timerState.startTimer {
                    if timerState.isTimerRunning {
                        Text("일시정지")
                    } else {
                        Text("재개")
                    }
                } else {
                    Text("시작")
                }
            }
            .frame(width: 80, height: 80)
            .background(timerState.isTimerRunning ? Circle().foregroundColor(Color(uiColor: .gray000)) : Circle().foregroundColor(Color(uiColor: .lightBlue500)))
            .foregroundColor(timerState.isTimerRunning ? Color(uiColor: .lightBlue500) : Color(uiColor: .gray000))
            .clipShape(Circle())
        }
    }
}
