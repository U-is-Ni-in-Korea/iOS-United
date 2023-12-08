import AudioToolbox
import Combine
import Foundation

class TimerData: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    @Published var showToast: Bool = false
    @Published var isTimerRunning: Bool = false
    @Published var startTimer: Bool = false
    @Published var selectedMinute: Int = 5
    @Published var selectedSecond: Int = 0
    @Published var remainingTime: Int = 0
    @Published var totalTime: Int = 0
    @Published var endTimerAlert: Bool = false
    private var timer: AnyPublisher<Date, Never>!
    init() {
        setupTimer()
    }
    private func setupTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
        timer
            .sink { [weak self] _ in
                self?.updateTimer()
            }
            .store(in: &cancellables)
    }
    private func updateTimer() {
        if isTimerRunning {
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                AudioServicesPlaySystemSound(1005)
                isTimerRunning = false
                showToast = true
                startTimer = false
                endTimerAlert = true
            }
        }
    }
    func toggleTimer() {
        isTimerRunning.toggle()
    }
    func makeTime() {
        remainingTime = selectedMinute * 60 + selectedSecond
        totalTime = selectedMinute * 60 + selectedSecond
    }
    func hideEndTimerAlert() {
        endTimerAlert = false
    }
}
