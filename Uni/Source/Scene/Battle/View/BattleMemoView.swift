import SwiftUI
import SDSKit

struct BattleMemoView: View {
    @State var alertIsShown = false
    @State private var memoText: String = MemoTextManager.shared.memoText
    @State private var placeHolder = "묻고 답한 내용을 기록해보세요"
    @State private var backButtonTapped: Bool = false
    @ObservedObject var viewData: BattleMemoViewData
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                BattleMemoNavigaionView(label: "메모장") {
                    alertIsShown = true
                }
                ZStack(alignment: .topLeading) {
                    if memoText.isEmpty {
                        TextEditor(text: $placeHolder)
                            .foregroundColor(Color(uiColor: .gray300))
                            .font(Font(SDSFont.body1.font))
                            .colorMultiply(Color(uiColor: .gray100))
                    }
                    TextEditor(text: $memoText)
                        .foregroundColor(Color(uiColor: .gray600))
                        .font(Font(SDSFont.body1.font))
                        .colorMultiply(Color(uiColor: .gray100))
                        .opacity(memoText.isEmpty ? 0.25 : 1)
                }
                .padding(.horizontal, 24)
                .padding(. vertical, 16)
            }
            if alertIsShown {
                BattleMemoAlertView(cancelButtonTapped: $alertIsShown, exitButtonTapped: $backButtonTapped)
            }
        }
        .background(Color(uiColor: .gray100))
        .onChange(of: backButtonTapped) { _ in
            MemoTextManager.shared.memoText = memoText
            alertIsShown.toggle()
            viewData.dismissButtonTapPublisher.send()
        }
    }
}

struct BattleMemoAlertView: View {
    @Binding var cancelButtonTapped: Bool
    @Binding var exitButtonTapped: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(Color(uiColor: .gray600))
                .opacity(0.4)
            VStack(alignment: .center, spacing: 0) {
                Text("메모장을 나가시나요?")
                    .font(Font(SDSFont.subTitle.font))
                    .foregroundColor(Color(uiColor: .gray600))
                    .padding(.top, 24)
                Text("승부가 끝나기 전에는 내용이 남아있지만 \n 앱을 종료하면 내용이 사라질 수 있어요")
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

struct BattleMemoNavigaionView: View {
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
            }
            .frame(width: 24, height: 24)
            .padding(.leading, 10)
            Spacer()
            Text(label)
                .font(Font(SDSFont.subTitle.font))
                .foregroundColor(Color(uiColor: .gray600))
            Spacer()
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
    }
}
