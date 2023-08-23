//
//  WithdrawViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit

final class WithdrawViewController: BaseViewController {

    var withdrawView = WithdrawView()

    override func viewDidLoad() {
        super.viewDidLoad()
        withdrawViewActions()
    }

    override func loadView() {
        super.loadView()
        setStyle()
    }

}

extension WithdrawViewController {

    private func setStyle() {
        withdrawView = WithdrawView(frame: self.view.frame)
        self.view = withdrawView
    }

    func withdrawViewActions() {
        self.withdrawView.askWithdrawAlertView.cancelButtonTapCompletion = { [self] in
            self.dismiss(animated: true)
        }
    }

}
