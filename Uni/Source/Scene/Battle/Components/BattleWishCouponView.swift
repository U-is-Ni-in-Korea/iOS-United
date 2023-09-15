//
//  File.swift
//
//
//  Created by 홍유정 on 2023/07/11.
//
import UIKit
import SDSKit
import SnapKit


public class BattleWishCouponView: UIView {
    weak var delegate: CouponTextDelegate?
    weak var textViewStateDelegate: CouponTextStateDelegate?
    let wishCouponPlaceholder: String = "이번 승부에 걸 소원을 입력해주세요!\n소원은 지금 정하지 않고 승부가 끝난 뒤\n사용할 수도 있어요"
    
    let wishCouponBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray000
        view.layer.cornerRadius = 6
        return view
    }()
    
    let wishCouponTextBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var wishCouponTextView: UITextView = {
        let textview = UITextView()
        textview.font = SDSFont.body2.font
        textview.backgroundColor = .clear
        textview.textContainerInset = .zero
        return textview
    }()
    
    let dashlineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.backgroundColor = .gray000
        return stackView
    }()
    
    let dashView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var wishCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/54"
        label.textColor = .gray200
        label.font = SDSFont.caption.font
        return label
    }()
            
    func setTextView() {
        wishCouponTextView.delegate = self
        wishCouponTextView.text = wishCouponPlaceholder
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        wishCouponTextView.attributedText = NSAttributedString(string: wishCouponTextView.text, attributes: [NSAttributedString.Key.paragraphStyle: style])
        wishCouponTextView.textColor = .gray300
    }
    
    func maskCoupon() {
        let circleSize = 20
        let maskLayer = CAShapeLayer()
        let backgroundPath = UIBezierPath(rect: wishCouponBackgroundView.bounds)
        let transparentLeftPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: -10, y: 46), size: CGSize(width: circleSize, height: circleSize)), cornerRadius: CGFloat(circleSize/2))
        let transparentRightPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: wishCouponBackgroundView.frame.maxX - 10, y: 46), size: CGSize(width: circleSize, height: circleSize)), cornerRadius: CGFloat(circleSize/2))


        let combinedPath = UIBezierPath()
        
        combinedPath.append(backgroundPath)
        combinedPath.append(transparentLeftPath)
        combinedPath.append(transparentRightPath)
        
        maskLayer.fillRule = .evenOdd
        maskLayer.path = combinedPath.cgPath
        wishCouponBackgroundView.layer.mask = maskLayer
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        maskCoupon()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    public init() {
        super.init(frame: .zero)
        setLayout()
        setTextView()
        self.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setLayout() {
        
        addSubview(wishCouponBackgroundView)
        [wishCouponTextBackgroundView, dashlineStackView, wishCountLabel].forEach { wishCouponBackgroundView.addSubview($0)}
        wishCouponTextBackgroundView.addSubview(wishCouponTextView)
        
        for _ in 0...6 {
            let verticalView = UIView()
            verticalView.backgroundColor = .gray100
            self.dashlineStackView.addArrangedSubview(verticalView)
        }
  
        self.snp.makeConstraints {
            $0.height.equalTo(112)
            $0.width.equalTo(334)
        }
        wishCouponBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        wishCouponTextBackgroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().inset(77)
            $0.height.equalTo(80)
        }
        wishCouponTextView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview().inset(10)
        }
        
        dashlineStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(wishCouponTextBackgroundView.snp.trailing).offset(16)
            $0.width.equalTo(5)
        }
        
        wishCountLabel.snp.makeConstraints {
            $0.leading.equalTo(dashlineStackView.snp.trailing).offset(11)
            $0.bottom.equalToSuperview().inset(11)
        }
    }
}

extension BattleWishCouponView: UITextViewDelegate {

    public func textViewDidBeginEditing(_ textView: UITextView) {
        wishCouponTextBackgroundView.layer.borderWidth = 1
        wishCouponTextBackgroundView.layer.borderColor = UIColor.lightBlue500.cgColor

        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            wishCouponTextView.textColor = .gray300
            wishCouponTextView.text = wishCouponPlaceholder
        } else if textView.text == wishCouponPlaceholder {
            wishCouponTextView.textColor = .gray600
            wishCouponTextView.text = ""
        }
    }

    public func textViewDidChange(_ textView: UITextView) {

        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        textView.attributedText = NSAttributedString(string: textView.text, attributes: [NSAttributedString.Key.paragraphStyle: style])

        if wishCouponTextView.text.count > 54 {
            wishCouponTextView.deleteBackward()
        } else if wishCouponTextView.text.count >= 54 {
            wishCouponTextBackgroundView.layer.borderColor = UIColor.red500.cgColor
            wishCountLabel.textColor = .red500
        }
        else {
            wishCouponTextView.textColor = .gray600
            wishCountLabel.textColor = .gray200
            wishCouponTextBackgroundView.layer.borderColor = UIColor.lightBlue500.cgColor
        }
        wishCountLabel.text = "\(wishCouponTextView.text.count)/54"
        
        if let text = wishCouponTextView.text {
            delegate?.getCouponText(text: text)
            if text.count >= 54 {
                textViewStateDelegate?.checkTextViewState(state: false)
            } else {
                textViewStateDelegate?.checkTextViewState(state: true)
            }
        }
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        wishCouponTextBackgroundView.layer.borderWidth = 0
        if wishCouponTextView.text.isEmpty {
            wishCouponTextView.text = wishCouponPlaceholder
            wishCouponTextView.textColor = .gray300
        }
    }
}
