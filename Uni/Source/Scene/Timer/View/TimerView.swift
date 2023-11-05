//
//  TimerView.swift
//  Uni
//
//  Created by 홍유정 on 2023/10/04.
//

import SwiftUI
import SDSKit

struct TimerView: View {

    @StateObject var timerState = TimerState()

    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: .gray100)
                    .ignoresSafeArea()

                VStack {
                    if timerState.startTimer {
                        TimerProgressView()

                    } else {
                        TimerPickerView()
                            .frame(height: 250)
                            .pickerStyle(WheelPickerStyle())
                            .padding()
                    }

                    TimerButtonView()
                        .padding()

                    TimerTipView()
                        .opacity(timerState.startTimer ? 0 : 1.0)
                }
                .environmentObject(timerState)
            }
            .navigationTitle("타이머")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        print("backbuttontapped")
                    }, label: {
                        Image(uiImage: SDSIcon.icChevronLeft)
                    })
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
