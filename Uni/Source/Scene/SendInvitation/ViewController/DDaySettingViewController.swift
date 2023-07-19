//
//  DDaySettingViewController.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/15.
//

import Foundation
import UIKit

final class DDaySettingViewController: BaseViewController {
    // MARK: - Property
    private var dateString: String = ""
    private let dDayRepository = DDayRepository()

    // MARK: - UI Property
    private var dDaySettingView = DDaySettingView()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        dDaySettingView = DDaySettingView(frame: self.view.frame)
        view = dDaySettingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConfig()
        actions()
    }

    // MARK: - Setting
    override func setLayout() {
        super.setLayout()
    }
    override func setConfig() {
        super.setConfig()
        

    }

    // MARK: - Action Helper
    private func actions() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(nextButtonTapped))
        tapGesture.delegate = self
        dDaySettingView.nextButton.addGestureRecognizer(tapGesture)
        dDaySettingView.dDayDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    @objc func nextButtonTapped() {
        if dateString == "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateString = dateFormatter.string(from: Date())
        }
        print(dateString)
        view.showIndicator()
        dDayRepository.postDday(startDate: dateString) { success in
            if success {
                self.view.removeIndicator()
                let coupleConnectionMethodView = CoupleConnectionMethodViewController()
                self.navigationController?.pushViewController(coupleConnectionMethodView, animated: true)
            }
            else {
                self.view.removeIndicator()
            }
        }
    }
    @objc func dateChanged() {
        let selectedDate = dDaySettingView.dDayDatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateString = dateFormatter.string(from: selectedDate)
    }

    // MARK: - Custom Method
  
}
extension DDaySettingViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
