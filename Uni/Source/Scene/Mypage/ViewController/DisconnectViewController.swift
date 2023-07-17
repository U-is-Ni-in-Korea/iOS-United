//
//  DisconnectViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit

class DisconnectViewController: UIViewController {

    var disconnectView = DisconnectView()

    override func viewDidLoad() {
        super.viewDidLoad()
        disconnectActions()
    }
    
    override func loadView() {
        super.loadView()
        
        disconnectView = DisconnectView(frame: self.view.frame)
        self.view = disconnectView
    }
    
    func disconnectActions() {
        self.disconnectView.askDisconnectAlertView.cancelButtonTapCompletion = { [self] in
            self.dismiss(animated: true)
        }
    }


}
