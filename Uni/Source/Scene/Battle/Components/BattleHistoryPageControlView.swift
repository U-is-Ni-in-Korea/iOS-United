import SwiftUI

import SDSKit

struct BattleHistoryPageControlView: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            ForEach(0..<numberOfPages, id: \.self) { page in
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(page == currentPage ? Color(uiColor: .lightBlue600) : Color(uiColor: .lightBlue200))
            }
        }
        .frame(height: 34)
    }
}
