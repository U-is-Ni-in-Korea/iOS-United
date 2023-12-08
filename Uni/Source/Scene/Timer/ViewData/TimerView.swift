import SwiftUI
import SDSKit

struct TimerView: View {
    @State private var alertIsShown = false
    @State private var backButtonTapped: Bool = false
    @State private var exitButtonTapped: Bool = false
    @State private var isTimerRunning: Bool = false
    @ObservedObject var timerData: TimerData
    @ObservedObject var timerViewData: TimerViewData
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                BattleTimerNavigaionView(label: "타이머") {
                    alertIsShown = true
                }
                if timerData.startTimer {
                    TimerProgressView(timerState: timerData)
                        .padding(.horizontal, 24)
                        .padding(.top, 32)
                } else {
                    TimerPickerView(timerState: timerData)
                        .frame(height: UIScreen.main.bounds.size.width - 48)
                        .padding(.horizontal, 24)
                        .padding(.top, 32)
                        .pickerStyle(WheelPickerStyle())
                }
                TimerButtonView(timerState: timerData)
                    .padding(.horizontal, 16)
                TimerTipView()
                    .opacity(timerData.startTimer ? 0 : 1.0)
                    .padding(.top, 32)
                    .padding(.horizontal, 16)
                Spacer()
            }
            if timerData.endTimerAlert {
                VStack {
                    Spacer()
                    TimerToastView()
                        .padding(.top, 61)
                }
            }
            if alertIsShown {
                BattleTimerAlertView(cancelButtonTapped: $alertIsShown, exitButtonTapped: $exitButtonTapped)
            }
        }
        .background(Color(uiColor: .gray100))
        .onChange(of: backButtonTapped) { _ in
            alertIsShown.toggle()
        }
        .onChange(of: exitButtonTapped) { _ in
            timerViewData.popButtonTapPublisher.send()
        }
        .onChange(of: timerData.endTimerAlert) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                timerData.hideEndTimerAlert()
            }
        }
    }
}

struct BattleTimerAlertView: View {
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
                Text("타이머가 아직 끝나지 않았어요")
                    .font(Font(SDSFont.subTitle.font))
                    .foregroundColor(Color(uiColor: .gray600))
                    .padding(.top, 24)
                Text("타이머는 종료되지 않지만 죵료 알림을 받을 수 없어요")
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

struct BattleTimerNavigaionView: View {
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
