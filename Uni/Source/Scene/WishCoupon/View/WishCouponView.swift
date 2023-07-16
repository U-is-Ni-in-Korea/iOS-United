//
//  WishCouponView.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/16.
//

import UIKit
import Then
import SDSKit

final class WishCouponView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    private var wishCouponCountView = WishCouponCountView()
    
    let navigationBar = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "소원권") //백버튼 크기 변경
    
//    let historyTableView = UITableView().then {
//        $0.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
//        $0.rowHeight = 103 // 셀의 높이
//        $0.separatorStyle = .none // 셀의 구분선 없애기
//    }
    
    // MARK: - Life Cycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyle()
        setLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setStyle()
        setLayout()
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        self.backgroundColor = .gray100
    }
    
    private func setLayout() {
        [navigationBar, wishCouponCountView].forEach {
            addSubview($0)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        wishCouponCountView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(82)
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    
}
