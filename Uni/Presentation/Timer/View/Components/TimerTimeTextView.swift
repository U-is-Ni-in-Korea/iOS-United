import SwiftUI
import SDSKit

struct TimerTimeTextView: View {
    // MARK: - Property
    let text: String
    // MARK: - UI Property
    var body: some View {
        Text(text)
            .font(Font(SDSFont.body1.font))
            .foregroundColor(Color(.gray600))
    }
}
