//
//  DisconnectViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit

class DisconnectViewController: BaseViewController {

    var disconnectView = DisconnectView()

    override func viewDidLoad() {
        super.viewDidLoad()
        disconnectViewActions()
    }
    
    override func loadView() {
        super.loadView()
        
        disconnectView = DisconnectView(frame: self.view.frame)
        self.view = disconnectView
    }
    
    func disconnectViewActions() {
        self.disconnectView.askDisconnectAlertView.cancelButtonTapCompletion = { [self] in
            self.dismiss(animated: true)
        }
    }


}
