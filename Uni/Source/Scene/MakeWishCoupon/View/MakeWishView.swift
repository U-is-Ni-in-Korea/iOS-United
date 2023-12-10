import UIKit
import SDSKit
import Then

class MakeWishView: UIView {
    // MARK: - UI Property
    private let leftBackgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "leftBackground")
    }
    private let rightBackgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "rightBackground")
    }
    private let makeWishBackgroundView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let naviBackgroundView = UIView().then {
        $0.applyNavigationBarShadow()
    }
    let makeWishViewNavi = SDSNavigationBar(hasBack: false, hasTitleItem: false, navigationTitle: "소원권 만들기", rightBarButtonImages: [SDSIcon.icDismiss])
    let writeWishTitleLabel = UILabel().then {
        $0.text = "소원 작성하기"
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    private let writeWishMessageLabel = UILabel().then {
        $0.text = "한번 만들어진 소원은 수정할 수 없어요"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }
    let writeWishView = WriteWishView().then {
        $0.layer.cornerRadius = 16
    }
    var makeWishButton = SDSButton(type: .fill, state: .disabled).then {
        $0.titleLabel?.textColor = .gray000
    }
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyle()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setting
    private func setStyle() {
        self.backgroundColor = .gray000
    }
    private func setLayout() {
        addSubviews([leftBackgroundImageView, rightBackgroundImageView, makeWishBackgroundView])
        makeWishBackgroundView.addSubviews([naviBackgroundView, makeWishViewNavi, writeWishTitleLabel, writeWishMessageLabel, writeWishView, makeWishButton])

        leftBackgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        rightBackgroundImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/7)
        }
        makeWishBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        makeWishViewNavi.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        naviBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(makeWishViewNavi.snp.bottom)
        }
        writeWishTitleLabel.snp.makeConstraints {
            $0.top.equalTo(makeWishViewNavi.snp.bottom).offset(UIScreen.main.bounds.height/50)
            $0.leading.equalToSuperview().inset(20)
        }
        writeWishMessageLabel.snp.makeConstraints {
            $0.top.equalTo(writeWishTitleLabel.snp.bottom).offset(UIScreen.main.bounds.height/135)
            $0.leading.equalToSuperview().inset(20)
        }
        writeWishView.snp.makeConstraints {
            $0.top.equalTo(writeWishMessageLabel.snp.bottom).offset(UIScreen.main.bounds.height/50)
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().inset(37)
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/5)
        }
        makeWishButton.snp.makeConstraints {
            $0.top.equalTo(writeWishView.snp.bottom).offset(UIScreen.main.bounds.height/14)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
