import SwiftUI
import SDSKit

struct NicknameSettingView: View {
    // MARK: - Property
    @Environment(\.presentationMode) var presentationMode //네비게이션 링크로 현재 뷰와 연결되면 이 버튼 누르면 원래 버튼으로 이동
    @State private var Shown = false
    @State private var buttonClicked: ClickedButton = .none
    @State private var showAlert = false
    @State private var text: String = ""
    @State private var color: Color = Color(uiColor: .gray200)
    @State private var count: Int = 0
    @ObservedObject private var viewModel: NickNameInputViewModel
    init(viewModel: NickNameInputViewModel) {
        self.viewModel = viewModel
    }
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NicknameSettingNavigationView {
                viewModel.pop()
            }
            nickNameInputTextView
            VStack {
                nicknameTextView
                nicknameWarningView
            }
            Spacer()
            HStack {
                Button(action: {
                    viewModel.pushToQnAView()
                }, label: {
                    Text("문의하기")
                        .font(Font(SDSFont.body2.font))
                        .foregroundColor(Color(uiColor: .gray300))
                        .frame(width: 69, height: 28)
                })
                Spacer()
                Button(action: {
                    viewModel.showLogOutAlert()
                },
                       label: {
                    Text("로그아웃")
                        .font(Font(SDSFont.body2.font))
                        .foregroundColor(Color(uiColor: .gray300))
                        .frame(width: 69, height: 28)
                })
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            Button {
                viewModel.nextButtonTap()
            } label: {
                Text("다음")
                    .foregroundColor(Color(uiColor: .gray000))
                    .font(Font(SDSFont.subTitle.font))
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(viewModel.nextButtonActiveRule() ? Color(uiColor: .lightBlue500) : Color(uiColor: .gray300))
                    .cornerRadius(10)
            }
            .disabled(viewModel.nextButtonActiveRule() ? false : true)
            .padding(.horizontal, 20)
            .padding(.bottom, 16)

        }
    }
}
// MARK: - Extensions
extension NicknameSettingView {
    private var nickNameInputTextView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("사용할 닉네임을 입력하세요")
                .font(Font(SDSFont.subTitle.font))
                .foregroundColor(Color(uiColor: .gray600))
                .padding(.top, 58)
            Text("상대가 나를 부르는 애칭은 무엇인가요?")
                .font(Font(SDSFont.body2Long.font))
                .foregroundColor(Color(uiColor: .gray350))
                .padding(.top, 6)
        }
        .padding(.leading, 20)
    }
    private var nicknameTextView: some View {
        VStack {
            TextField("닉네임", text: $text)
                .padding(.leading, 14)
                .frame(width: 335, height: 48)
                .accentColor(Color(uiColor: .lightBlue500)) // 임의로 지정함
                .foregroundColor(Color(uiColor: .gray600))
                .font(Font(SDSFont.body2Long.font))
                .onChange(of: text) { text in
                    self.text = String(text.prefix(10))
                    viewModel.nickName = self.text
                    viewModel.nickNameLenght = viewModel.nickName.count
                    viewModel.setCurrentState()
                }
        }
        .foregroundColor(Color(uiColor: .gray200))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(viewModel.stateColor, lineWidth: 1))
        .padding(.top, 11)
    }
    private var nicknameWarningView: some View {
        HStack(spacing: 4) {
            Text("글자수를 초과했어요")
                .font(Font(SDSFont.caption.font))
                .foregroundColor(self.viewModel.nickNameLenght > 5 ? Color(uiColor: .red500) : Color(uiColor: .gray000))
            Spacer()
            Text("\(self.viewModel.nickNameLenght)")
                .font(Font(SDSFont.caption.font))

                .foregroundColor(self.viewModel.nickNameLenght > 5 ? Color(uiColor: .red500) : Color(uiColor: .gray400))
                .frame(width: 13, height: 18)
            Text("/")
                .font(Font(SDSFont.caption.font))

                .foregroundColor(self.viewModel.nickNameLenght > 5 ? Color(uiColor: .red500) : Color(uiColor: .gray400))
                .frame(width: 5, height: 18)

            Text("5")
                .font(Font(SDSFont.caption.font))

                .foregroundColor(self.viewModel.nickNameLenght > 5 ? Color(uiColor: .red500) : Color(uiColor: .gray400))
                .frame(width: 8, height: 18)
                .padding(.trailing, 1)
        }
        .padding(.horizontal, 20)

    }
}

struct NicknameSettingNavigationView: View {
    let action: () -> Void
    init(action: @escaping () -> Void) {
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
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
    }
}
