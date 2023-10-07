import SwiftUI

import SDSKit

struct BattleHistoryGameProcessContentView: View {
    var content: String
    var title: String
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("icCheckMark")
                    .resizable()
                    .frame(width: 32, height: 32)
                Text(title)
                    .foregroundColor(Color(uiColor: .gray600))
                    .font(Font(SDSFont.btn2.font))
                Spacer()
            }
            .frame(height: 46)
            .padding(.top, 17)
            .padding(.bottom, 14)
            Rectangle()
                .foregroundColor(Color(uiColor: .gray200))
                .frame(height: 1)
            Spacer()
            HStack(alignment: .center) {
                Text(content)
                    .foregroundColor(Color(uiColor: .gray600))
                    .font(Font(SDSFont.body2Long.font))
            }
            Spacer()
        }
        .padding([.leading, .trailing], 12)
        .frame(width: UIScreen.main.bounds.size.width - 40)
        .background(Color(uiColor: .gray000))
        .cornerRadius(10)
    }
}
