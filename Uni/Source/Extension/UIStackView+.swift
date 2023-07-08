import UIKit

extension UIStackView {
    func addArrangeSubViews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
