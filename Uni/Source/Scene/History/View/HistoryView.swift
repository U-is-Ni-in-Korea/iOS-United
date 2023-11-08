import UIKit

import SDSKit
import SnapKit
import Then

final class HistoryView: UIView {
    // MARK: - UI Property
    private var historyEmptyView = HistoryEmptyView()
    let navigationBar = SDSNavigationBar(hasBack: true, hasTitleItem: true, navigationTitle: "승부 히스토리")
    let historyTableView = UITableView().then {
        $0.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        $0.rowHeight = 103
        $0.separatorStyle = .none
    }
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setStyle()
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setStyle()
    }
    // MARK: - Setting
    private func setStyle() {
        self.backgroundColor = .gray100
    }
    private func setLayout() {
        [navigationBar, historyEmptyView, historyTableView]
            .forEach { addSubview($0) }
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        historyTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        historyEmptyView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    // MARK: - Custom Method
    func hasHistoryData(hasData: Bool) {
        if hasData {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.historyEmptyView.isHidden = true
                self.historyTableView.isHidden = false
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.historyEmptyView.isHidden = false
                self.historyTableView.isHidden = true

            }
        }
    }
}
