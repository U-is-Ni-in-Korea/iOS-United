import XCTest
@testable import Uni

final class BattleHistoryItemViewDataTests: XCTestCase {
    var sut: BattleHistoryItemViewData!
    var battleHistoryResult: BattleHistoryResultDTO!
    
    override func setUpWithError() throws {
        sut = BattleHistoryItemViewData(battleHistoryItem: battleHistoryResult)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
