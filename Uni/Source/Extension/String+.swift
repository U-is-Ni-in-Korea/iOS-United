import UIKit
import Sentry

extension String {
    func setAttributeString(textColor: UIColor, font: UIFont) -> AttributedString {
        let attirbuteTitle = NSMutableAttributedString(string: self, attributes: [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: textColor
        ])
        return AttributedString(attirbuteTitle)
    }
    
    func setAttributeString(textColor: UIColor, font: UIFont, kern: Float) -> NSAttributedString {
        let attirbuteTitle = NSMutableAttributedString(string: self, attributes: [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.kern: kern
        ])
        return attirbuteTitle
    }
    
    func setAttributeString(range: NSRange, font: UIFont, textColor: UIColor) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(.foregroundColor, value: textColor, range: range)
        attributeString.addAttribute(.font, value: font, range: range)
        return attributeString
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isContainEnglish() -> Bool {
        let pattern = "[A-Za-z]+"
        guard let isContain = self.range(of: pattern, options: .regularExpression) else { return false}
        return true
    }
    
    func isContainNumber() -> Bool {
        let pattern = ".*[0-9]+.*"
        guard let isContain = self.range(of: pattern, options: .regularExpression) else { return false}
        return true
    }
    
    func isContainNumberAndAlphabet() -> Bool {
        let pattern = "^[0-9a-zA-Z]*$"
        guard let isContain = self.range(of: pattern, options: .regularExpression) else { return false}
        return true
    }
    
    func setRemoveImoji() -> String {
        let emojiPattern = "[\\p{Emoji}]"
        if let regex = try? NSRegularExpression(pattern: emojiPattern, options: []) {
            let modifiedString = regex.stringByReplacingMatches(
                in: self,
                options: [],
                range: NSRange(location: 0, length: self.utf16.count),
                withTemplate: ""
            )
            
            print(modifiedString)
            return modifiedString
        } else {
            return ""
        }
        
    }
    
    func isLengthOver(lenght: Int) -> Bool {
        if self.count >= lenght {
            return true
        } else {
            return false
        }
    }
    
    func stringToDate(toformat: String, fromFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = toformat
        let date = formatter.date(from: self)
        
        guard let returnDateString = date?.toString(dateFormat: fromFormat) else {return ""}
        return returnDateString
    }
}
