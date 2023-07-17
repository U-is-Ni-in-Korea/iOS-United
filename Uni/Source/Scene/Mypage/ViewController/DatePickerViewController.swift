//
//  DatePickerViewController.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/15.
//

import UIKit

class DatePickerViewController: UIViewController {

    var dateCompletionHandler: ((String) -> Void)?

    var datePickerView = DatePickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actions()
    }
    
    override func loadView() {
        super.loadView()
        datePickerView = DatePickerView(frame: self.view.frame)
        self.view = datePickerView
    }
    
    private func actions() {
        datePickerView.baseButton.addTarget(self, action: #selector(baseButtonTapped), for: .touchUpInside)
        datePickerView.cancelButton.addTarget(self, action: #selector(baseButtonTapped), for: .touchUpInside)
        datePickerView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    @objc func baseButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func doneButtonTapped() {
        self.dismiss(animated: true)
        dateCompletionHandler?(datePickerView.newAnniversaryDate)
    }

}
