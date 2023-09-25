import UIKit
import SDSKit
import SnapKit
import Then

final class BattleResultViewController: BaseViewController {

    override func loadView() {
        super.loadView()
        self.view = battleResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavigationButtonAction()
        self.addGesture()
        self.getBattleResult()
    }
    
    private func addNavigationButtonAction() {
        self.battleResultView.naviagationBar.dismissButtonTapCompletion = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dismiss(animated: true)
        }
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(resultButtonTap))
        tapGesture.delegate = self
        self.battleResultView.resultButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func resultButtonTap() {
        if self.battelData?.myRoundMission.finalResult == "WIN" {
            //소원권으로 이동 완, userID 보내야함 todo
            print("win은인식함")
            let wishCouponVC = WishCouponViewController()
            guard let pvc = self.presentingViewController else { return }
            self.dismiss(animated: true) {
                if let navigation = pvc as? UINavigationController {
                    navigation.pushViewController(wishCouponVC, animated: true)
                }
            }
        } else {
            self.dismiss(animated: true)
        }
    }
    
    private func getBattleResult() {
        self.view.showIndicator()
        print("getBattleResult 시작전")
        battlerRepository.getRoundGameData(roundId: self.roundId) { [weak self] data in
            guard let strongSelf = self else {return}
            print("getBattleResult")
            strongSelf.battelData = data
            strongSelf.bindMyInfoView(data: data)
            strongSelf.bindOtherInfoView(data: data)
            strongSelf.view.removeIndicator()
        }
    }
    private func getRoundMissionId() {
        self.view.showIndicator()
        print("getRoundMissionId시작전")
        homeRepository.getHomeData { [weak self] data in
            guard let strongSelf = self else {return}
            print(data, "데이터!!")
            if let roundId = data.roundGameId {
                print("getRoundMissionId")
//                strongSelf.getBattleResult(roundId: roundId)
                strongSelf.view.removeIndicator()
            }
        }
    }
    
    
    private func bindMyInfoView(data: RoundBattleDataModel) {
        self.setSectionData(state: data.myRoundMission.finalResult)
        
        self.battleResultView.myBattleResultView.bindText(sectionTitle: "나의 미션",
                                                                title: data.myRoundMission.missionContent.content,
                                                                summary: data.myRoundMission.missionContent.missionCategory.title)
        let date = (data.myRoundMission.updatedAt ?? "").stringToDate(toformat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", fromFormat: "HH:mm")
        
        if data.myRoundMission.result == "WIN" {
            self.battleResultView.myBattleResultView.bindChipText(title: date,
                                                                  subTitle: "미션 성공",
                                                                  status: .win)
        }
        else {
            self.battleResultView.myBattleResultView.bindChipText(subTitle: "미션 실패",
                                                                  status: .lose)
        }
    }
    //WIN, LOSE, DRAW, UNDECIDED
    private func bindOtherInfoView(data: RoundBattleDataModel) {
//        let date = (data.partnerRoundMission?.updatedAt ?? "").stringToDate(toformat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", fromFormat: "HH:mm")
//        self.battleResultView.otherBattleResultView.bindText(sectionTitle: "상대의 미션",
//                                                             title: data.partnerRoundMission?.missionContent.content ?? "",
//                                                             summary: data.partnerRoundMission?.missionContent.missionCategory.title)
//        if data.partnerRoundMission?.result == "WIN" {
//            self.battleResultView.otherBattleResultView.bindChipText(title: date,
//                                                                     subTitle: "미션 성공",
//                                                                     status: .win)
//        }
//        else if data.partnerRoundMission?.result == "LOSE" {
//            self.battleResultView.otherBattleResultView.bindChipText(subTitle: "미션 실패",
//                                                                     status: .lose)
//        }
//        else if data.partnerRoundMission?.result == "UNDECIDED" {
//            self.battleResultView.otherBattleResultView.bindText(sectionTitle: "상대의 미션",
//                                                                 title: "",
//                                                                 status: .progress)
//            self.battleResultView.otherBattleResultView.bindChipText(subTitle: "",
//                                                                     status: .progress)
//        }
    }
    
    private func setSectionData(state: String) {
        self.battleResultView.setButtonConfig(type: .showHome)
        switch state {
        case "WIN":
            self.battleResultView.statusSectionTitle.text = "멋진 승리네요!"
            self.battleResultView.illustImageView.image = UIImage(named: "imgCardWin")
            self.battleResultView.setButtonConfig(type: .showWish)
        case "LOSE":
            self.battleResultView.statusSectionTitle.text = "아쉬운 패배네요"
            self.battleResultView.illustImageView.image = UIImage(named: "imgCardLose")
        case "DRAW":
            self.battleResultView.statusSectionTitle.text = "앗! 무승부에요"
            self.battleResultView.illustImageView.image = UIImage(named: "imgCardDraw")
        default:
            self.battleResultView.statusSectionTitle.text = "승부 종료 후 히스토리에서 최종 결과를 확인하세요"
            self.battleResultView.illustImageView.image = UIImage(named: "imgCardProgress")
        }
    }
    
    
    private let battleResultView = BattleResultView()
    private let battlerRepository = BattleRepository()
    private let homeRepository = HomeRepository()
    private var battelData: RoundBattleDataModel?
    var roundId: Int = 0

}
extension BattleResultViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
