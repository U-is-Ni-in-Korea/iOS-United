import Foundation

extension Date {
    static func getCurrentYear() -> String{
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let str = dateFormatter.string(from: nowDate)
        return str
    }
    
    static func getCurrentMonth() -> String{
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let str = dateFormatter.string(from: nowDate)
        return str
    }
    
    static func getCurrentDay() -> String{
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let str = dateFormatter.string(from: nowDate)
        return str
    }
    
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return dateFormatter.string(from: self)
    }
    
    func convertStringToTimeStamp(date: String) -> Int {
        if date == "" {return 0}
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let convertDate = dateFormatter.date(from: date)
        let convertTimeStamp = Int(convertDate!.timeIntervalSince1970)
        return convertTimeStamp
    }
}
