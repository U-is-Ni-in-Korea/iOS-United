import UIKit
import SDSKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    func removeAllSubViews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }

    func addGradient(size: CGSize,
                     colors: [CGColor],
                     startPoint: CGPoint,
                     endPoint: CGPoint) {
        removeGradient()
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: .zero, size: size)
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint

        self.layer.insertSublayer(gradient, at: 0)
        self.layer.setNeedsDisplay()
    }
    func removeGradient() {
        if let gradientLayer = (self.layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
            gradientLayer.removeFromSuperlayer()
        }
    }

    @discardableResult
    func drawShadow(color: UIColor,
                    opacity: Float,
                    offset: CGSize,
                    radius: CGFloat) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        return self
    }
    
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    func captureAsImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        guard let pngData = image.pngData() else { return nil }
        return UIImage(data: pngData)
    }

}
