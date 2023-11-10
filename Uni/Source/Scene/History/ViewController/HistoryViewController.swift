import UIKit

import Then
import SDSKit
import SkeletonView

final class HistoryViewController: BaseViewController {
    // MARK: - Property
    var historyData: [HistoryDataModel] = []
    // MARK: - UI Property
    private var historyView = HistoryView()
    private let historyRepository = HistoryRepository()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        historyView = HistoryView(frame: self.view.frame)
        self.view = historyView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setLayout()
        historyNaviActions()
        startSkeletonView()
        fetchDataSource()
    }
    // MARK: - Setting
    private func setDelegate() {
        historyView.historyTableView.dataSource = self
        historyView.historyTableView.delegate = self
    }
    // MARK: - Action Helper
    func historyNaviActions() {
        self.historyView.navigationBar.backButtonCompletionHandler = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)
        }
    }
    // MARK: - Custom Method
    func startSkeletonView() {
        self.view.isSkeletonable = true
        historyView.historyTableView.isSkeletonable = true
        let skeletonAnimation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        historyView.historyTableView.showAnimatedGradientSkeleton(usingGradient: .init(colors: [.gray150, .gray100]), animation: skeletonAnimation, transition: .crossDissolve(2))
    }
    func fetchDataSource() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.historyRepository.getHistoryData { [weak self] data in
                guard let self = self else { return }
                self.historyData = data
                if self.historyData.count == 0 {
                    self.view.hideSkeleton()
                    self.historyView.hasHistoryData(hasData: false)
                } else {
                    self.view.hideSkeleton()
                    self.historyView.hasHistoryData(hasData: true)
                    self.historyView.historyTableView.reloadData()
                }
            }
          }
    }
}
// MARK: - UITableView Delegate
extension HistoryViewController: UITableViewDelegate {
}
// MARK: - UITableView DataSource
extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count // 뷰 컨에 보일 셀 수
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell
        else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none // 셀 눌렀을 때 클릭한 거 안 보이게
        cell.configureCell(historyData: historyData[indexPath.row]) // 셀에 내용을 붙여주는 함수를 불러온 것
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let historyDetailViewController = HistoryDetailViewController()
        let selectedHistoryData = historyData[indexPath.row]
        historyDetailViewController.dataBind(historyData: selectedHistoryData)
        navigationController?.pushViewController(historyDetailViewController, animated: true)
    }
}

extension HistoryViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return HistoryTableViewCell.identifier
    }
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        skeletonView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath)
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
}
