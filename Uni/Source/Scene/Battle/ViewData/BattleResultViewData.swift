import Combine

class BattleResultViewData: ObservableObject, NavigationBarProtocol {
    var dismissButtonTapPublisher = PassthroughSubject<Void, Never>()
    var checkResultButtonTapPublisher = PassthroughSubject<Void, Never>()
    var findWishCouponButtonTapPublisher = PassthroughSubject<Void, Never>()
    var goHomeButtonTapPublisher = PassthroughSubject<Void, Never>()
    @Published var battleResultData: BattleResultDataModel? = nil
    @Published var roundData: RoundBattleDataModel? = nil
}
