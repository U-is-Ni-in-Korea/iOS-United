//
//  DatePickerView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/15.
//

import UIKit
import SDSKit
import Then

class DatePickerView: UIView {

    let baseButton = UIButton()
    
    let emptyView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 13
        $0.backgroundColor = .gray000
    }
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.timeZone = NSTimeZone.local
        $0.maximumDate = Date() //오늘 이후 날짜 블러 및 선택 불가
        $0.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    }
    
    let buttonStackBackView = UIView().then {
        $0.backgroundColor = .gray200
    }
    
    let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 1
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.gray600, for: .normal)
        $0.titleLabel?.font = SDSFont.body1.font
        $0.backgroundColor = .gray000
    }
    
    let doneButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.gray600, for: .normal)
        $0.titleLabel?.font = SDSFont.body1.font
        $0.backgroundColor = .gray000
    }
    
    var newAnniversaryDate: String = "****년 **월 **일"
    
    @objc func dateChange(_ sender: UIDatePicker) {
        newAnniversaryDate = dateFormat(date: sender.date)
    }

    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.4)
    }
    
    private func setLayout() {
        
        self.addSubviews([baseButton])
        baseButton.addSubview(emptyView)
        emptyView.addSubviews([datePicker, buttonStackBackView])
        buttonStackBackView.addSubview(buttonStackView)
        buttonStackView.addArrangeSubViews([cancelButton, doneButton])
        
        baseButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(280)
            $0.center.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(76)
            $0.height.equalTo(100)
        }
        
        buttonStackBackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }

}
