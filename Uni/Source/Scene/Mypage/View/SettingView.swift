//
//  SettingView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/14.
//

import UIKit
import SDSKit
import Then

class SettingView: UIView {
    
    weak var delegate: SettingViewDelegate?

    let settingViewNavi = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "마이페이지")
    public let profileView = MyPageProfileView()
    private let myPageTitleList = MyPageTitle.myPageTitleList()
            
    private let myPageTableView = UITableView().then {
        $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.reuseIdentifier)
        $0.rowHeight = 56
        $0.separatorStyle = .none
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyle()
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        self.backgroundColor = .gray000
    }
    
    func setLayout() {
        addSubviews([settingViewNavi,profileView,myPageTableView])
        
        settingViewNavi.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(settingViewNavi.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(148)
        }
        
        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
}

extension SettingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.reuseIdentifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        
        cell.myPageConfigureCell(myPageTitleList[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
            
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SettingTableViewHeaderView()
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCell(at: indexPath)
    }

}

protocol SettingViewDelegate: AnyObject {
    func didSelectCell(at indexPath: IndexPath)
}
