import Foundation
import UIKit
import SDSKit
import SnapKit
import Then
import Kingfisher

final class BattleCategoryView: UIView {
    var makeButtonTapCompletion: ((SDSButtonState) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(type: BattleCategoryType) {
        super.init(frame: .zero)
        self.setLayout(type: type)
        self.addButtonGesture()
    }
    
    func bindText(missionData: BattleDataModel, contentList: [MissionContentList]? = nil, type: BattleCategoryType) {
        missionTitleLabel.text = missionData.title
        missionDescriptionLabel.text = missionData.description
        ruleDescriptionView.bindText(description: missionData.rule)
        tipDescriptionView.bindText(description: missionData.tip)
        if let url = URL(string: missionData.image) {
            iconImageView.kf.setImage(with: url)
        }
        
        if type == .select {
            guard let content = contentList else {return}
            firstExampleDescriptionView.bindText(description: content[0].content)
            secondExampleDescriptionView.bindText(description: content[1].content)
        }
        
        
    }
    
    private func setLayout(type: BattleCategoryType) {
        
        
        
        self.backgroundColor = .gray100
        self.addSubviews([navigationBar, scrollView])
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
        }
        
        self.setTitleSectionLayout()
        self.setRuleSectionLayout()
        self.setTipSectionLayout()
        
        switch type {
        case .select:
            self.setExampleSectionLayout()
            stackView.addArrangeSubViews([titleSectionView, ruleSectionView, tipSectionView, exmapleSectionView, creatButton])
            creatButton.snp.makeConstraints {
                $0.top.equalTo(self.exmapleSectionView.snp.bottom).offset(32)
                $0.height.equalTo(48)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().inset(16)
                $0.width.equalTo(UIScreen.main.bounds.width - 40)
            }
        case .none:
            stackView.addArrangeSubViews([titleSectionView, ruleSectionView, tipSectionView])
        }
        
    }
    
    private func setTitleSectionLayout() {
        titleSectionView.addSubviews([iconImageView, missionTitleLabel, missionDescriptionLabel])
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(77)
        }
        missionTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(16)
        }
        missionDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(missionTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(16)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setRuleSectionLayout() {
        ruleSectionView.addSubviews([ruleSectionTitleView, ruleDescriptionView])
        ruleSectionTitleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        ruleDescriptionView.snp.makeConstraints {
            $0.top.equalTo(ruleSectionTitleView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setTipSectionLayout() {
        tipSectionView.addSubviews([tipSectionTitleView, tipDescriptionView])
        tipSectionTitleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        tipDescriptionView.snp.makeConstraints {
            $0.top.equalTo(tipSectionTitleView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setExampleSectionLayout() {
        exmapleSectionView.addSubviews([exampleSectionTitleView, exampleDescriptionStackView])
        exampleSectionTitleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        exampleDescriptionStackView.snp.makeConstraints {
            $0.top.equalTo(exampleSectionTitleView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        exampleDescriptionStackView.addArrangeSubViews([firstExampleDescriptionView, secondExampleDescriptionView])
    }
    
    let navigationBar = SDSNavigationBar(hasBack: true,
                                         hasTitleItem: true)
    let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.contentInset = .init(top: 0, left: 0, bottom: 32, right: 0)
    }
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 12
    }
    
    //titleSection
    let titleSectionView = UIView().then {
        $0.backgroundColor = .clear
    }
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    let missionTitleLabel = UILabel().then {
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    let missionDescriptionLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textColor = .gray350
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    //ruleSection
    let ruleSectionView = UIView().then {
        $0.backgroundColor = .clear
    }
    let ruleSectionTitleView = SectionView().then {
        $0.bindText(title: "세부 룰")
    }
    let ruleDescriptionView = CategoryDescriptionView()
    //tipSection
    let tipSectionView = UIView().then {
        $0.backgroundColor = .clear
    }
    let tipSectionTitleView = SectionView().then {
        $0.bindText(title: "공략 팁")
    }
    let tipDescriptionView = CategoryDescriptionView()
    //exampleSection
    let exmapleSectionView = UIView().then {
        $0.backgroundColor = .clear
    }
    let exampleSectionTitleView = SectionView().then {
        $0.bindText(title: "미션 예시")
    }
    let exampleDescriptionStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 9
    }
    let firstExampleDescriptionView = CategoryDescriptionView()
    let secondExampleDescriptionView = CategoryDescriptionView()
//    let completeButton = SDSButton(type: .fill, state: .enabled).then {
//        $0.setButtonTitle(title: "선택하기")
//    }
    let creatButton = SDSButton(type: .fill, state: .enabled).then {
        $0.setButtonTitle(title: "한판 승부 만들기")
    }
    
    @objc private func createButtonTap() {
        guard let completion = makeButtonTapCompletion else {return}
        completion(creatButton.buttonState)
    }
    
    func addButtonGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(createButtonTap))
        tapGesture.delegate = self
        self.creatButton.addGestureRecognizer(tapGesture)
    }
    
    
}

extension BattleCategoryView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
