//
//  TimerToastView.swift
//  Uni
//
//  Created by 홍유정 on 10/8/23.
//

import SwiftUI

struct TimerToastView: View {

    @EnvironmentObject var timerState: TimerState

    var body: some View {
        VStack {
            Text("타이머가 종료되었어요")
                .foregroundStyle(Color(uiColor: .gray000))
                .padding()
                .background(Color(uiColor: .gray450))
                .clipShape(Capsule())
                .opacity(timerState.showToast ? 1.0 : 0.0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            timerState.showToast = false
                        }
                    }
                }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
