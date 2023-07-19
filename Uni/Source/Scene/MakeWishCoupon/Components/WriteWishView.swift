//
//  WriteWishView.swift
//  Uni
//
//  Created by 홍유정 on 2023/07/17.
//

import UIKit
import SDSKit
import Then

class WriteWishView: UIView {
    
    weak var delegate: WriteWishViewDelegate?
    
    let myWishIsLabel = UILabel().then {
        $0.text = "나의 소원은"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }
    
    lazy var writeWishTextView = UITextView().then {
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
        $0.backgroundColor = .clear
        $0.textAlignment = .center
    }
    
    let writeWishPlaceholder: String = "소원을 입력해주세요"
    
    lazy var wishLetterCountLabel = UILabel().then {
        $0.font = SDSFont.caption.font
        $0.textColor = .gray400
        $0.text = "0/54"
    }
    
    let dashlineStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
        $0.backgroundColor = .clear
    }
    
    let expirationDateTitleLabel = UILabel().then {
        $0.text = "유효기간"
        $0.font = SDSFont.body2.font
        $0.textColor = .gray400
    }
    
    let expirationDateLabel = UILabel().then {
        $0.text = "우리가 사랑할때까지"
        $0.font = SDSFont.subTitle.font
        $0.textColor = .gray600
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setTextView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextView() {
        writeWishTextView.delegate = self
        writeWishTextView.text = writeWishPlaceholder
        writeWishTextView.textColor = .gray300
    }
    
    private func setLayout() {
        
        self.layer.applyDepthAndDepth3_1Shadow()
        self.applyDepth3_2Shadow()

        addSubviews([myWishIsLabel, writeWishTextView, wishLetterCountLabel, dashlineStackView, expirationDateTitleLabel, expirationDateLabel])
        
        for _ in 0...24 {
            let horizontalView = UIView()
            horizontalView.backgroundColor = .gray200
            self.dashlineStackView.addArrangedSubview(horizontalView)
        }
        
        myWishIsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height/9)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        writeWishTextView.snp.makeConstraints {
            $0.top.equalTo(myWishIsLabel.snp.bottom).offset(UIScreen.main.bounds.height/29)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(UIScreen.main.bounds.height/10)
        }
        
        wishLetterCountLabel.snp.makeConstraints {
            $0.top.equalTo(writeWishTextView.snp.bottom)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        dashlineStackView.snp.makeConstraints {
            $0.top.equalTo(wishLetterCountLabel.snp.bottom).offset(UIScreen.main.bounds.height/8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        expirationDateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dashlineStackView.snp.bottom).offset(UIScreen.main.bounds.height/20)
            $0.centerX.equalToSuperview()
        }
        expirationDateLabel.snp.makeConstraints {
            $0.top.equalTo(expirationDateTitleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height/20)
        }
        
    }
    
}

extension WriteWishView: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            writeWishTextView.textColor = .gray300
            writeWishTextView.text = writeWishPlaceholder
        } else if textView.text == writeWishPlaceholder {
            writeWishTextView.textColor = .gray600
            writeWishTextView.text = ""
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        textView.attributedText = NSAttributedString(string: textView.text, attributes: [NSAttributedString.Key.paragraphStyle: style])
        
        if writeWishTextView.text.count > 60 {
            writeWishTextView.deleteBackward()
            writeWishTextView.layer.borderWidth = 1
            writeWishTextView.layer.borderColor = UIColor.red500.cgColor
        } else if 54 < writeWishTextView.text.count  {
            wishLetterCountLabel.textColor = .red500
            writeWishTextView.layer.borderWidth = 1
            writeWishTextView.layer.borderColor = UIColor.red500.cgColor
        }
        else {
            writeWishTextView.textColor = .gray600
            wishLetterCountLabel.textColor = .gray400
            writeWishTextView.layer.borderWidth = 0

        }
        
        wishLetterCountLabel.text = "\(writeWishTextView.text.count)/54"
        
        if writeWishTextView.text.isEmpty || writeWishTextView.text.count > 54 {
            delegate?.disableTextView()
        } else if writeWishTextView.text != writeWishPlaceholder {
            delegate?.enableTextView()
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        writeWishTextView.layer.borderWidth = 0
        
        if writeWishTextView.text.isEmpty {
            writeWishTextView.text = writeWishPlaceholder
            writeWishTextView.textColor = .gray300
            delegate?.disableTextView()
        } else {
            delegate?.enableTextView()
            writeWishTextView.textAlignment = .center
        }
    }
}

protocol WriteWishViewDelegate: AnyObject {
    func enableTextView()
    func disableTextView()
}
