import UIKit

final class BattleWriteViewController: BaseViewController {

    override func loadView() {
        super.loadView()
        self.view = battleWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var battleWriteView = BattleWriteView()
}
