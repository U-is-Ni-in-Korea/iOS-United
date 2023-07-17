import UIKit

final class BattleHistoryViewController: BaseViewController {

    override func loadView() {
        super.loadView()
        self.view = battleHistoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var battleHistoryView = BattleHistoryView()
}
