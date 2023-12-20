import SwiftUI

import SDSKit

struct BattleHistoryBottomView: View {
    var viewData: BattleProgressViewModel
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(uiColor: .gray200))
            Spacer()
            HStack(alignment: .center) {
                Button {
                    viewData.missionCompleteButtonTapSubject.send()
                } label: {
                    Text("미션 완료")
                        .font(Font(SDSFont.btn1.font))
                        .foregroundColor(Color(uiColor: .gray000))
                }
                .frame(width: UIScreen.main.bounds.size.width / 2 - 20, height: 48)
                .background(Color(uiColor: .lightBlue500))
                .cornerRadius(10)
                Button {
                    viewData.missionFailureButtonTapSubject.send()
                } label: {
                    Text("미션 실패")
                        .font(Font(SDSFont.btn1.font))
                        .foregroundColor(Color(uiColor: .lightBlue600))
                }
                .frame(width: UIScreen.main.bounds.size.width / 2 - 20, height: 48)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(uiColor: .lightBlue500), lineWidth: 1)
                )

            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width, height: 104)
        .background(Color(uiColor: .gray000))
        .padding([.leading, .trailing], 20)
    }
}
