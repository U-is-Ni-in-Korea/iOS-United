import SwiftUI
import SDSKit

struct TimerToastView: View {
    var body: some View {
        VStack {
            Text("타이머가 종료되었어요")
                .font(Font(SDSFont.body2.font))
                .foregroundStyle(Color(uiColor: .gray000))
                .padding(.horizontal, 18)
                .padding(.vertical, 9)
                .background(Color(uiColor: .gray450))
                .clipShape(Capsule())
        }
    }
}
