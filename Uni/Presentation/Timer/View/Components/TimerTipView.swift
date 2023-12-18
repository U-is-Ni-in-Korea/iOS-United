import SwiftUI
import SDSKit

struct TimerTipView: View {
    // MARK: - UI Property
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("타이머 활용법")
                .font(Font(SDSFont.subTitle.font))
                .foregroundStyle(Color(uiColor: .lightBlue500))
                .padding(.top, 12)
                .padding(.leading, 12)
            Text("추천하는 제한 시간은 5분입니다\n타이머를 설정하고 원하는 시간 동안 승부를 즐겨보세요")
                .lineLimit(2)
                .lineSpacing(10.0)
                .font(Font(SDSFont.body2Long.font))
                .foregroundStyle(Color(uiColor: .gray600))
                .padding(.top, 10)
                .padding(.bottom, 12)
                .padding(.horizontal, 12)
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .gray000))
        .cornerRadius(10.0)
    }
}
