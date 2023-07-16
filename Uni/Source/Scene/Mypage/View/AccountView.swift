//
//  AccountView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

final class AccountView: UIView {
    
    private let accountViewNavi = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "계정")
    private let accountTitleList = AccountTitle.accountTitleList()
    
    private let accountTableView = UITableView().then {
        $0.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.idf)
        $0.rowHeight = 56
        $0.separatorStyle = .none
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
        accountTableView.delegate = self
        accountTableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        self.backgroundColor = .gray000
    }
    private func setLayout() {
        
        addSubviews([accountViewNavi, accountTableView])
        
        accountViewNavi.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        accountTableView.snp.makeConstraints {
            $0.top.equalTo(accountViewNavi.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
}

extension AccountView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.idf, for: indexPath) as? AccountTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(accountTitleList[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}
