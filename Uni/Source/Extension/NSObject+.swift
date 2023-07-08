import UIKit

protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

extension NSObject: ReuseIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
