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
    
    weak var delegate: AccountViewDelegate?
    
    public var accountViewNavi = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "계정")
    private let accountTitleList = AccountTitle.accountTitleList()
    
    private let accountTableView = UITableView().then {
        $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.idf)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.idf, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        cell.accountConfigureCell(accountTitleList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCell(at: indexPath)
    }
}

protocol AccountViewDelegate: AnyObject {
    func didSelectCell(at indexPath: IndexPath)
}
