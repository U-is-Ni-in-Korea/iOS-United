//
//  TimerPickerView.swift
//  Uni
//
//  Created by 홍유정 on 2023/09/30.
//

import SwiftUI
import SDSKit

struct TimerPickerView: View {
    @ObservedObject var timerState: TimerData
    var body: some View {
        HStack {
            Picker("MinutePicker", selection: $timerState.selectedMinute) {
                ForEach(0 ..< 59) {
                    Text("\($0)")
                }
            }
            Text("분")
                .font(Font(SDSFont.body1.font))
                .foregroundColor(Color(.gray600))
            Picker("SecondPicker", selection: $timerState.selectedSecond) {
                ForEach(0 ..< 59) {
                    Text("\($0)")
                }
            }
            Text("초")
                .font(Font(SDSFont.body1.font))
                .foregroundColor(Color(.gray600))
        }
    }
}
