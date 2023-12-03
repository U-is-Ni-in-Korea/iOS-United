import SwiftUI

import SDSKit

struct BattleResultView: View {
    @ObservedObject var data: BattleResultViewData
    @State private var myMissionOpen = true
    @State private var yourMissionOpen = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBarView(viewData: data, title: "한판 승부 결과")
            HStack(alignment: .center) {
                ZStack {
                    if data.battleResultData?.myRoundMission == nil {
                        BattleResultMisstionView(
                            missionTitle: "나의 미션",
                            mission: data.roundData?.myRoundMission?.missionContent.content,
                            keyword: data.roundData?.myRoundMission?.missionContent.missionCategory.title,
                            updatedTime: data.roundData?.myRoundMission?.updatedAt,
                            result: data.roundData?.myRoundMission?.result)
                            .padding(.leading, 20)
                    } else {
                        BattleResultMisstionView(
                            missionTitle: "나의 미션",
                            mission: data.battleResultData?.myRoundMission?.missionContent.content,
                            keyword: data.battleResultData?.myRoundMission?.missionContent.missionCategory.title,
                            updatedTime: data.battleResultData?.myRoundMission?.updatedAt,
                            result: data.battleResultData?.myRoundMission?.result)
                            .padding(.leading, 20)
                    }
                }
                if data.battleResultData?.partnerRoundMission == nil {
                    VStack(alignment: .leading, spacing: 0) {
                        BattleResultTitleView(title: "상대의 미션")
                        VStack(alignment: .center, spacing: 0) {
                            Text("승부가 끝난 뒤 \n공개")
                                .font(Font(SDSFont.body2.font))
                                .foregroundColor(Color(uiColor: .gray300))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: (UIScreen.main.bounds.size.width - 40) / 2 - 5, height: ((UIScreen.main.bounds.size.width - 40) / 2 - 5) * 130 / 163)
                        .background(Color(uiColor: .gray150))
                        .cornerRadius(10)
                    }
                } else {
                    BattleResultMisstionView(
                        missionTitle: "상대의 미션",
                        mission: data.battleResultData?.partnerRoundMission?.missionContent.content,
                        keyword: data.battleResultData?.partnerRoundMission?.missionContent.missionCategory.title,
                        updatedTime: data.battleResultData?.partnerRoundMission?.updatedAt,
                        result: data.battleResultData?.partnerRoundMission?.result,
                        finalResult: data.battleResultData?.partnerRoundMission?.finalResult)
                        .padding(.trailing, 20)
                }
            }
            .padding(.bottom, 16)
            ZStack {
                if data.battleResultData?.partnerRoundMission == nil {
                    BattleResultTitleView(title: "승부 결과를 기다리고 있어요")
                        .padding(.leading, 20)
                } else {
                    BattleResultTitleView(title:
                                            data.battleResultData?.myRoundMission?.finalResult == "UNDECIDED" ? "승부 결과를 기다리고 있어요" :
                                            data.battleResultData?.myRoundMission?.finalResult == "WIN" ? "멋진 승리네요!" :
                                            data.battleResultData?.myRoundMission?.finalResult == "DRAW" ? "앗! 무승부에요" :
                                            "아쉬운 패배네요")
                        .padding(.leading, 20)
                }
            }
            ZStack {
                if data.battleResultData?.partnerRoundMission == nil {
                    VStack {
                        Image("imgCardProgress")
                        .resizable()
                            .scaledToFit()
                    }
                    .frame(minWidth: UIScreen.main.bounds.size.width - 40, maxHeight: UIScreen.main.bounds.size.width - 40)
                    .background(Color(uiColor: .gray000))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                } else {
                    VStack {
                        Image(
                            data.battleResultData?.myRoundMission?.finalResult == "UNDECIDED" ? "imgCardProgress" :
                                data.battleResultData?.myRoundMission?.finalResult == "WIN" ? "imgCardWin" :
                                data.battleResultData?.myRoundMission?.finalResult == "DRAW" ? "imgCardDraw" :
                            "imgCardLose"
                        )
                        .resizable()
                            .scaledToFit()
                    }
                    .frame(minWidth: UIScreen.main.bounds.size.width - 40, maxHeight: UIScreen.main.bounds.size.width - 40)
                    .background(Color(uiColor: .gray000))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }
            }
            Spacer()
            ZStack {
                if data.battleResultData?.partnerRoundMission == nil {
                    BattleResultBottomButton(buttonTitle: "최종 결과 확인하기", viewData: data)
                        .padding(.leading, 20)
                } else {
                    FinalResultBottomButton(viewData: data)
                        .padding(.leading, 20)
                }
            }
        }
        .background(Color(uiColor: .gray100))
    }
}

struct BattleResultMisstionView: View {
    var missionTitle: String
    var mission: String?
    var keyword: String?
    var updatedTime: String?
    var result: String?
    var finalResult: String?
    var missionViewColor: Color {
        switch result {
        case "WIN":
            return Color(uiColor: .green50)
        case "LOSE":
            return Color(uiColor: .pink50)
        default:
            return .black
        }
    }
    var missionTextColor: Color {
        switch result {
        case "WIN":
            return Color(uiColor: .green600)
        case "LOSE":
            return Color(uiColor: .pink600)
        default:
            return .black
        }
    }
    var missionText: String {
        switch result {
        case "WIN":
            return "미션 성공"
        case "LOSE":
            return "미션 실패"
        default:
            return ""
        }
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BattleResultTitleView(title: missionTitle)
            VStack {
                VStack(alignment: .center, spacing: 0) {
                    HStack(spacing: 0) {
                        Text(mission ?? "")
                            .foregroundColor(Color(uiColor: .gray600))
                            .font(Font(SDSFont.btn2.font))
                            .padding([.leading, .top], 20)
                        Spacer()
                    }
                    HStack(spacing: 0) {
                        Text(keyword ?? "")
                            .foregroundColor(Color(uiColor: .gray600))
                            .font(Font(SDSFont.btn2.font))
                            .padding(.top, 6)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Spacer()
                    HStack(spacing: 0) {
                        HStack(alignment: .center) {
                            Text((updatedTime ?? "").stringToDate(toformat: "yyyy-MM-dd'T'HH:mm:ss.SSSSSS", fromFormat: "HH:mm") + " \(missionText)")
                                .font(Font(SDSFont.caption.font))
                                .foregroundColor(missionTextColor)
                        }
                        .frame(height: 26)
                        .padding(.horizontal, 16)
                        .background(missionViewColor)
                        .cornerRadius(13)
                        .padding([.leading, .bottom], 20)
                        Spacer()
                    }
                }
                .frame(width: (UIScreen.main.bounds.size.width - 40) / 2 - 5, height: ((UIScreen.main.bounds.size.width - 40) / 2 - 5) * 130 / 163)
                .background(Color(uiColor: .gray000))
                .cornerRadius(10)
            }

        }
    }
}

struct BattleResultTitleView: View {
    var title: String
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .foregroundColor(Color(uiColor: .gray600))
                .font(Font(SDSFont.subTitle.font))
                .padding(.vertical, 16)
        }
    }
}

struct BattleResultBottomButton: View {
    var buttonTitle: String
    var viewData: BattleResultViewData
    var body: some View {
        VStack(spacing: 0) {
            Button {
                viewData.checkResultButtonTapPublisher.send()
            } label: {
                VStack(alignment: .center) {
                    Text(buttonTitle)
                        .font(Font(SDSFont.btn1.font))
                        .foregroundColor(Color(uiColor: .lightBlue600))
                        .padding(.vertical, 12)
                }
                .frame(width: UIScreen.main.bounds.size.width - 40, height: 48)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(uiColor: .lightBlue500), lineWidth: 1))
            }
        }
        .padding(.vertical, 16)
    }
}

struct FinalResultBottomButton: View {
    var buttonTitle: String {
        switch viewData.battleResultData?.myRoundMission?.finalResult {
        case "DRAW":
            return "홈으로 돌아가기"
        default:
            return "소원권 조회하러 가기"
        }
    }
    var viewData: BattleResultViewData
    var textColor: Color {
        switch viewData.battleResultData?.myRoundMission?.finalResult {
        case "DRAW":
            return Color(uiColor: .lightBlue500)
        default:
            return Color(uiColor: .gray000)
        }
    }
    var backgroundColor: Color {
        switch viewData.battleResultData?.myRoundMission?.finalResult {
        case "DRAW":
            return Color(uiColor: .gray000)
        default:
            return Color(uiColor: .lightBlue500)
        }
    }
    var body: some View {
        VStack(spacing: 0) {
            Button {
                if viewData.battleResultData?.myRoundMission?.finalResult == "DRAW" {
                    viewData.goHomeButtonTapPublisher.send()
                } else {
                    viewData.findWishCouponButtonTapPublisher.send()
                }
            } label: {
                VStack(alignment: .center) {
                    Text(buttonTitle)
                        .font(Font(SDSFont.btn1.font))
                        .foregroundColor(textColor)
                        .padding(.vertical, 12)
                }
                .frame(width: UIScreen.main.bounds.size.width - 40, height: 48)
                .background(backgroundColor)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(uiColor: .lightBlue500), lineWidth: 1))
            }
        }
        .padding(.vertical, 16)
    }
}
