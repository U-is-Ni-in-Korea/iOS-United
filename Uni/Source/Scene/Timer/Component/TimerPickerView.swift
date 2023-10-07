//
//  TimerPickerView.swift
//  Uni
//
//  Created by 홍유정 on 2023/09/30.
//

import SwiftUI
import SDSKit

struct TimerPickerView: View {

    @EnvironmentObject var timerState: TimerState

    var body: some View {
        HStack {
            Picker("MinutePicker", selection: $timerState.selectedMinute) {
                ForEach(0 ..< 59) {
                    Text("\($0)")
                }
            }

            Text("분")

            Picker("SecondPicker", selection: $timerState.selectedSecond) {
                ForEach(0 ..< 59) {
                    Text("\($0)")
                }
            }

            Text("초")

        }
    }
}
