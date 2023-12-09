import SwiftUI
import SDSKit

struct QnANavigationView: View {
    let action: () -> Void
    let label: String
    init(label: String, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    var body: some View {
        HStack(alignment: .center) {
            Button {
                action()
            } label: {
                Image(uiImage: SDSIcon.icNavigationBarLeft)
                    .frame(width: 24, height: 24)
            }
            .padding(.leading, 10)
            Spacer()
            Text(label)
                .font(Font(SDSFont.subTitle.font))
                .foregroundColor(Color(uiColor: .gray600))
            Spacer()
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
    }
}
