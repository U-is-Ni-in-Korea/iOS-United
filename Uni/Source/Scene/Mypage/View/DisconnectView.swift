//
//  DisconnectView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit
import SDSKit
import Then

class DisconnectView: UIView {

    let askDisconnectAlertView = AlertView(title: "정말 커플 연결을 해제하시겠어요?", message: "해제하면 다시 되돌릴 수 없어요",cancelButtonMessage: "취소" ,okButtonMessage: "연결 해제", type: .alert)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        addSubview(askDisconnectAlertView)
        
        askDisconnectAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
