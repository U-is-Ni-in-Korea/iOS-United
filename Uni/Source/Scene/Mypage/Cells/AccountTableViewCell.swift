//
//  AccountTableViewCell.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

class AccountTableViewCell: UITableViewCell {
    
    static let idf = "AccountTableViewCell"
    
    private let accountTitleLabel = UILabel().then {
        $0.font = SDSFont.body2.font
        $0.textColor = .gray600
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        addSubview(accountTitleLabel)
        
        accountTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureCell(_ accountTitle: AccountTitle) {
        accountTitleLabel.text = accountTitle.title
    }

}
