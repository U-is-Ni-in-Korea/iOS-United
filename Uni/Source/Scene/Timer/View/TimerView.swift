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

                    TimerToastView()
                        .padding(.top, 61)
                }
                .environmentObject(timerState)
                .padding(.top, 32)
            }
            .navigationTitle(Text("타이머").font(Font(SDSFont.subTitle.font)))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
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
