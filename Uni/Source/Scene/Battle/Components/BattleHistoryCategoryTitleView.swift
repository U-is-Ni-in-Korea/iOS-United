import SwiftUI

import SDSKit

struct BattleHistoryCategoryTitleView: View {
    var title: String
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .foregroundColor(Color(uiColor: .gray600))
                .font(Font(SDSFont.subTitle.font))
                .padding([.top, .bottom], 16)
            Spacer()
        }
        .padding([.leading, .trailing], 20)
    }
}
