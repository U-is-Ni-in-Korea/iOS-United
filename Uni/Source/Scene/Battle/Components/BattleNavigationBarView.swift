import SwiftUI

import SDSKit

struct BattleNavigationBarView: View {
    var viewData: BattleHistoryViewData
    var body: some View {
        HStack(alignment: .center) {
            Text("한판 승부 진행 중")
                .foregroundColor(Color(uiColor: .gray600))
                .font(Font(SDSFont.title1.font))
                .padding(.leading, 20)
            Spacer()
            Button {
                viewData.dismissButtonTapPublisher.send()
            } label: {
                Image(uiImage: SDSIcon.icDismiss)
            }
            .frame(width: 36, height: 36)
            .foregroundColor(Color(uiColor: .gray600))
            .padding(.trailing, 20)
        }
        .frame(height: 52)
    }
}
