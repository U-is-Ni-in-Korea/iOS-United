import SwiftUI
import SDSKit

struct QnAView: View {
    // MARK: - Property
    @State private var Shown = false
    @State private var buttonClicked: ClickedButton = .none
    @State private var showSettingAlert = false
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: QnAViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                QnANavigationView(label: "문의하기") {
                    viewModel.popViewController()
                }
                qnaLinkView
                accountCancellationView
                Spacer()
                infoView
            }
            if Shown {
                QnAViewAlert(Shown: $Shown, buttonClicked: $buttonClicked)
            }
        }
    }
}
// MARK: - Extensions
extension QnAView {
    private var qnaLinkView: some View {
        Link(destination: URL(string: "https://sparkle-uni.notion.site/eb45a613d2be46a6b11c5111759600b2?pvs=4")!) {
            HStack {
                Text("QnA")
                    .font(Font(SDSFont.body2.font))
                    .foregroundColor(Color(uiColor: .gray600))
                    .padding(.leading, 20)
                Spacer()
                Image("icChevronRight28")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.trailing, 20)
            }
            .frame(height: 56)
        }
    }
    private var accountCancellationView: some View {
        HStack {
            Button(action: {
                viewModel.showDeleteUserAlert()
            }, label: {
                Text("계정 탈퇴")
                    .font(Font(SDSFont.body2.font))
                    .foregroundColor(Color(uiColor: .gray600))
                    .padding(.leading, 20)
                Spacer()
            })
            .frame(height: 56)
        }
    }
    private var infoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Contact us")
                .foregroundColor(Color(uiColor: .gray600))
                .font(Font(SDSFont.title2.font))
                .padding(.leading, 20)
                .padding(.top, 24)
            HStack(spacing: 0) {
                Text("이메일")
                    .foregroundColor(Color(uiColor: .gray350))
                    .font(Font(SDSFont.caption.font))
                    .frame(width: 32, height: 18)
                    .padding(.leading, 20)
                Text("sopt.uni@gmail.com")
                    .accentColor(Color(uiColor: .gray350)) // 이메일은 엑센트 컬러 사용
                    .font(Font(SDSFont.caption.font))
                    .frame(width: 111, height: 18)
                    .padding(.leading, 8)
                Spacer()
            }
            .padding(.top, 20)
            HStack(spacing: 0) {
                Text("instagram")
                    .foregroundColor(Color(uiColor: .gray350))
                    .font(Font(SDSFont.caption.font))
                    .frame(width: 59, height: 18)
                    .padding(.leading, 20)
                Text("sparkle.uni.official")
                    .foregroundColor(Color(uiColor: .gray350))
                    .font(Font(SDSFont.caption.font))
                    .frame(width: 100, height: 18)
                    .padding(.leading, 8)
                Spacer()
            }
            .padding(.top, 8)
            Spacer()
        }
        .background(Color(uiColor: .gray100))
        .frame(height: 184)
        .frame(maxWidth: .infinity)

    }
}
