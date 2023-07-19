//
//  MyPageTableViewCell.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

final class MyPageTableViewCell: UITableViewCell {
    
    static let idf = "MyPageTableViewCell"
    
    private let myPageTitleLabel = UILabel().then {
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
        addSubview(myPageTitleLabel)
        myPageTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func myPageConfigureCell(_ myPageTitle: MyPageTitle) {
        myPageTitleLabel.text = myPageTitle.title
    }
    
    func accountConfigureCell(_ accountTitle: AccountTitle) {
        myPageTitleLabel.text = accountTitle.title
    }

}
