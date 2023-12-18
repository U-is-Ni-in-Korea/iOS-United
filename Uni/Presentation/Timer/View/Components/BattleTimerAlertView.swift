import SwiftUI
import SDSKit

struct BattleTimerAlertView: View {
    // MARK: - Property
    @Binding var cancelButtonTapped: Bool
    @Binding var exitButtonTapped: Bool
    // MARK: - UI Property
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(Color(uiColor: .gray600))
                .opacity(0.4)
            VStack(alignment: .center, spacing: 0) {
                Text("타이머가 아직 끝나지 않았어요")
                    .font(Font(SDSFont.subTitle.font))
                    .foregroundColor(Color(uiColor: .gray600))
                    .padding(.top, 24)
                Text("타이머는 종료되지 않지만\n종료 알림을 받을 수 없어요")
                    .font(Font(SDSFont.body2Long.font))
                    .foregroundColor(Color(uiColor: .gray400))
                    .padding(.top, 8)
                Spacer()
                Rectangle()
                    .foregroundColor(Color(uiColor: .gray200))
                    .frame(height: 1)
                HStack(spacing: 0) {
                    Button {
                        cancelButtonTapped.toggle()
                    } label: {
                        Text("취소")
                            .foregroundColor(Color(uiColor: .lightBlue600))
                            .font(Font(SDSFont.body1Regular.font))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    Rectangle()
                        .foregroundColor(Color(uiColor: .gray200))
                        .frame(width: 1)
                    Button {
                        exitButtonTapped.toggle()
                    } label: {
                        Text("나가기")
                            .foregroundColor(Color(uiColor: .lightBlue600))
                            .font(Font(SDSFont.subTitle.font))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .frame(height: 53)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 168)
            .background(Color(uiColor: .gray000))
            .cornerRadius(10)
            .padding(.horizontal, 52)
        }
    }
}
