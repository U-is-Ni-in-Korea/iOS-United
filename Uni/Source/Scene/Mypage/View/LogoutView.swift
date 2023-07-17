//
//  LogoutView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit
import SDSKit
import Then

class LogoutView: UIView {

    let askLogoutAlertView = AlertView(message: "로그아웃 하시겠습니까?",cancelButtonMessage: "취소" ,okButtonMessage: "로그아웃", type: .alert)
    
    //message 폰트 변경
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        addSubview(askLogoutAlertView)
        
        askLogoutAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

}
