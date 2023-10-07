//
//  TimerProgressView.swift
//  Uni
//
//  Created by 홍유정 on 2023/09/30.
//

import AudioToolbox
import SwiftUI
import SDSKit

struct TimerProgressView: View {

    @EnvironmentObject var timerState: TimerState

    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 339, height: 339)
                .overlay(
                    Circle().stroke(Color(uiColor: .gray150), lineWidth: 8)
                )

            Circle()
                .fill(Color(uiColor: .gray000))
                .frame(width: 339, height: 339)
                .overlay(
                    Circle()
                        .trim(from: 0,
                              to: CGFloat(timerState.timeRemaining)/CGFloat(timerState.totalSeconds)
                             )
                        .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round
                                                  )
                        )
                        .foregroundColor(Color(uiColor: .lightBlue500))
                )
                .rotationEffect(.degrees(-90))

            HStack {
                Text(String(format: "%02d", timerState.timeRemaining/60))
                    .frame(width: 100)
                Text(" : ")
                Text(String(format: "%02d", timerState.timeRemaining%60))
                    .frame(width: 100)
            }
            .font(.system(size: 68))
        }
        .frame(height: 250)
        .padding()
        .onReceive(timer) { _ in
//            withAnimation {
                if timerState.isTimerRunning {
                    if timerState.timeRemaining > 0 {
                        timerState.timeRemaining -= 1
                    } else if timerState.timeRemaining == 0 {
                        AudioServicesPlaySystemSound(1005)
                    }
                }
//            }
        }
    }
}
