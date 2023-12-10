import UIKit
import Then
import SDSKit
import CHTCollectionViewWaterfallLayout

class WishCouponViewController: BaseViewController {
    // MARK: - UI Property
    private var wishCouponView = WishCouponView()
    private let wishCouponRepository = WishCouponRepository()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        actions()
        setConfig()
        backButtonTapped()
    }
    override func loadView() {
        super.loadView()
        wishCouponView = WishCouponView(frame: self.view.frame)
        self.view = wishCouponView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 나
        if let userId = UserDefaultsManager.shared.loadInt(.userId) {
            view.showIndicator()
            wishCouponRepository.getWishCouponData(userId: userId) { [weak self] data in
                guard let strongSelf = self else {return}
                print(data)
                strongSelf.configureData(wishCouponData: data)
                strongSelf.wishCouponView.myWishCouponData = data
                strongSelf.wishCouponView.wishCouponCollectionView.wishCouponCollectionView.reloadData()
                strongSelf.view.removeIndicator()
            }
        }
        // 너
        if let partnerId = UserDefaultsManager.shared.loadInt(.partnerId) {
            view.showIndicator()
            wishCouponRepository.getWishCouponData(userId: partnerId) { [weak self] data in
                guard let strongSelf = self else {return}
                print(data)
                strongSelf.wishCouponView.yourWishCouponData = data
                strongSelf.wishCouponView.wishCouponYourCollectionView.wishCouponYourCollectionView.reloadData()
                strongSelf.view.removeIndicator()
            }
        }
    }
    // MARK: - Setting
    internal override func setConfig() {
        self.wishCouponView.wishCouponCollectionView.delegate = self
        self.wishCouponView.wishCouponYourCollectionView.delegate = self
    }
    // MARK: - Action Helper
    private func actions() {
        wishCouponView.wishCouponCountView.myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        wishCouponView.wishCouponCountView.yourButton.addTarget(self, action: #selector(yourButtonTapped), for: .touchUpInside)
    }
    @objc func myButtonTapped() {
        switchToMyWishCouponView(showMyWishCoupon: true)
        print("switchMyButton")
    }
    @objc func yourButtonTapped() {
        switchToMyWishCouponView(showMyWishCoupon: false)
        print("switchYourButton")
    }
    func backButtonTapped() {
        self.wishCouponView.navigationBar.backButtonCompletionHandler = { self.navigationController?.popViewController(animated: true)
            print("백버튼 클릭해찌!")
        }
    }
    // MARK: - Custom Method
    private func switchToMyWishCouponView(showMyWishCoupon: Bool) {
        if showMyWishCoupon {
            /// 나의 소원권
            DispatchQueue.main.async {
                self.wishCouponView.wishCouponEmptyView.noneLabel.text = ""
                self.wishCouponView.wishCouponCollectionView.isHidden = false
                self.wishCouponView.wishCouponYourCollectionView.isHidden = true
                self.wishCouponView.wishCouponCountView.yourButton.setTitleColor(.gray300, for: .normal)
                self.wishCouponView.wishCouponCountView.yourButton.titleLabel?.font = SDSFont.body1Regular.font
                self.wishCouponView.wishCouponCountView.myButton.setTitleColor(.lightBlue600, for: .normal)
                self.wishCouponView.wishCouponCountView.myButton.titleLabel?.font = SDSFont.subTitle.font
                self.wishCouponView.wishCouponCollectionView.scrollToInitialPosition()
            }
        } else {
            /// 상대 소원권
            DispatchQueue.main.async {
//                var wishCouponYourData: WishCouponDataModel?
                if let count = self.wishCouponView.wishCouponYourCollectionView.wishCouponYourData?.wishCouponList.count {
                    if count == 0 {
                        self.wishCouponView.wishCouponYourCollectionView.isHidden = true
                        self.wishCouponView.wishCouponEmptyView.isHidden = false
                    } else {
                        self.wishCouponView.wishCouponYourCollectionView.isHidden = false
                        self.wishCouponView.wishCouponEmptyView.isHidden = true
                    }
                }
                self.wishCouponView.wishCouponEmptyView.noneLabel.text = "아직 상대의 소원권이 없어요"
                self.wishCouponView.wishCouponCollectionView.isHidden = true
                self.wishCouponView.wishCouponYourCollectionView.isHidden = false
                self.wishCouponView.wishCouponCountView.myButton.setTitleColor(.gray300, for: .normal)
                self.wishCouponView.wishCouponCountView.myButton.titleLabel?.font = SDSFont.body1Regular.font
                self.wishCouponView.wishCouponCountView.yourButton.setTitleColor(.lightBlue600, for: .normal)
                self.wishCouponView.wishCouponCountView.yourButton.titleLabel?.font = SDSFont.subTitle.font
                self.wishCouponView.wishCouponYourCollectionView.scrollToInitialPosition()
            }
        }
    }
    func configureData(wishCouponData: WishCouponDataModel) {
        wishCouponView.wishCouponCountView.countLabel.text = "사용 가능한 소원권이 \(wishCouponData.availableWishCoupon ?? 0)개 있어요"
    }
}
extension WishCouponViewController: WishCouponSelectedCollectionView {
    func selectPartnerCouponId(couponId: Int) {
        let couponDetailVC = YourWishViewController()
        couponDetailVC.wishId = couponId
        self.navigationController?.pushViewController(couponDetailVC, animated: true)
    }
    func selectCouponId(couponId: Int) {
        let couponDetailVC = MyWishViewController()
        couponDetailVC.wishId = couponId
        self.navigationController?.pushViewController(couponDetailVC, animated: true)
    }
    func selectMakeCoupon() {
        let makeCouponVC = MakeWishViewController()
        makeCouponVC.makeWishCompletionHandler = {
            if let userid = UserDefaultsManager.shared.loadInt(.userId),
               let partnerId = UserDefaultsManager.shared.loadInt(.partnerId) {
                self.view.showIndicator()
                self.wishCouponRepository.getWishCouponData(userId: userid) { [weak self] data in
                    guard let strongSelf = self else {return}
                    print(data)
                    strongSelf.configureData(wishCouponData: data)
                    strongSelf.wishCouponView.myWishCouponData = data
                    strongSelf.wishCouponView.wishCouponCollectionView.wishCouponCollectionView.reloadData()
                    strongSelf.view.removeIndicator()
                }
                // 너
                self.view.showIndicator()
                self.wishCouponRepository.getWishCouponData(userId: partnerId) { [weak self] data in
                    guard let strongSelf = self else {return}
                    print(data)
                    strongSelf.wishCouponView.yourWishCouponData = data
                    strongSelf.wishCouponView.wishCouponYourCollectionView.wishCouponYourCollectionView.reloadData()
                    strongSelf.view.removeIndicator()
                }
            }
        }
        makeCouponVC.modalPresentationStyle = .overFullScreen
        self.present(makeCouponVC, animated: true)
    }
}
