import SwiftUI
import Combine

final class TimerViewData: ObservableObject {
    var popButtonTapPublisher = PassthroughSubject<Void, Never>()
}
