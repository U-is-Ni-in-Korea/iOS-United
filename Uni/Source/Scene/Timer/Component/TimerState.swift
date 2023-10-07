//
//  TimerState.swift
//  Uni
//
//  Created by 홍유정 on 2023/09/30.
//

import Foundation
import SwiftUI

class TimerState: ObservableObject {

    @Published var startTimer: Bool = false
    @Published var isTimerRunning: Bool = false

    @Published var selectedMinute: Int = 5
    @Published var selectedSecond: Int = 0

    @Published var timeRemaining: Int = 300
    @Published var totalSeconds: Int = 300

}
