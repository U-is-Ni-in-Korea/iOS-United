import SwiftUI
import SDSKit

struct TimerPickerView: View {
    // MARK: - Property
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    // MARK: - UI Property
    var body: some View {
        HStack {
            Picker("MinutePicker", selection: $selectedMinute) {
                ForEach(0 ..< 59) {
                    Text("\($0)")
                }
            }
            TimerTimeTextView(text: "분")
            Picker("SecondPicker", selection: $selectedSecond) {
                ForEach(0 ..< 59) {
                    Text("\($0)")
                }
            }
            TimerTimeTextView(text: "초")
        }
    }
}
