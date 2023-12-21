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
        checkTimeInterval()
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
                UserDefaults.standard.removeObject(forKey: "existingCountData")
            }
        }
    }
    func checkTimeInterval() {
        NotificationCenter.default.addObserver(self, selector: #selector(adf(_:)), name: NSNotification.Name("remainTimerTime"), object: nil)
    }
    @objc func adf(_ notification: Notification) {
        let remainTimerTime = notification.userInfo?["time"] as? Int ?? 0
        print(remainTimerTime, "남아있는지 확인")
        if remainingTime - remainTimerTime > 0 {
            remainingTime -= remainTimerTime
        } else {
            if let remainTimerTime = UserDefaults.standard.object(forKey: "existingCountData") as? Int {
                AudioServicesPlaySystemSound(1005)
                isTimerRunning = false
                showToast = true
                startTimer = false
                endTimerAlert = true
                UserDefaults.standard.removeObject(forKey: "existingCountData")
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
