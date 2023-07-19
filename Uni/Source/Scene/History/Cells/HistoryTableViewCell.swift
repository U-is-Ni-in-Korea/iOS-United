//
//  HistoryTableViewCell.swift
//  Uni
//
//  Created by 김사랑 on 2023/07/14.
//

import UIKit
import Then
import SDSKit

final class HistoryTableViewCell: UITableViewCell {
    
    // MARK: - Property
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - UI Property
    
    private let gameDateLabel = UILabel().then {
        //        $0.text = "23.06.20"
        $0.textColor = .gray400
        $0.font = SDSFont.body2.font
    }
    
    private let gameImageView = UIImageView().then {
        $0.backgroundColor = .gray200 //이미지 변경하기
        $0.layer.cornerRadius = 8
    }
    
    private let textStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fillProportionally
    }
    
    private let gameNameLabel = UILabel().then {
        //        $0.text = "대답 유도하기"
        $0.textColor = .gray600
        $0.font = SDSFont.body1.font
    }
    
    private let gameResultLabel = UILabel().then {
        //        $0.text = "패배"
        $0.textColor = .lightBlue500
        $0.font = SDSFont.body2.font
    }
    
    private let nextImageView = UIImageView().then {
        $0.image = SDSIcon.icChevron.resize(targetSize: .init(width: 28, height: 28)).withTintColor(.gray200)
    }
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyle()
        setLayout()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0))
    }
    
    // MARK: - Setting
    
    private func setStyle() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
    }
    
    private func setLayout() {
        [gameDateLabel, gameImageView, textStackView, nextImageView].forEach {
            self.contentView.addSubview($0)
        }
        [gameNameLabel, gameResultLabel].forEach {
            textStackView.addArrangedSubview($0)
        }
        
        gameDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(12)
        }
        
        gameImageView.snp.makeConstraints {
            $0.top.equalTo(gameDateLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.height.width.equalTo(48)
        }
        
        textStackView.snp.makeConstraints {
            $0.top.equalTo(gameDateLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(gameImageView.snp.trailing).offset(16)
        }
        
        nextImageView.snp.makeConstraints {
            $0.centerY.equalTo(gameImageView)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(28)
        }
    }
    
    // MARK: - Action Helper
    
    // MARK: - Custom Method
    func configureCell(historyData: HistoryDataModel) { // 내용을 붙여주는 함수
        gameDateLabel.text = historyData.date ?? ""
        gameNameLabel.text = historyData.title ?? ""
        gameResultLabel.text = HistoryStatus(rawValue: historyData.result ?? "")?.getStatusT()
    }
}
