import Foundation

enum Key: String {
    case hasOnboarded
    case hasCoupleCode
    case lastRoundId
    case userId
    case partnerId
    case appVersion
    case inviteCode
}

class UserDefaultsManager {
    let defaults = UserDefaults.standard
    static let shared = UserDefaultsManager()
    private init() {}
    var hasPartnerId: Bool {
        if load(.partnerId) == nil {
            return false
        } else {
            return true
        }
    }
    var hasOnboarded: Bool {
        if load(.hasOnboarded) == nil {
            return false
        }
        else {
            return true
        }
    }
    var hasCoupleCode: Bool {
        if load(.hasCoupleCode) == nil {
            return false
        }
        else {
            return true
        }
    }
    var hasAppVersion: Bool {
        if load(.appVersion) == nil {
            return false
        } else {
            return true
        }
    }
    func load(_ key: Key) -> Any? {
        switch key {
        case .hasOnboarded:
            return loadBool(key)
        case .hasCoupleCode:
            return loadBool(key)
        case .lastRoundId:
            return loadInt(key)
        case .userId:
            return loadInt(key)
        case .partnerId:
            return loadInt(key)
        case .appVersion:
            return loadIntArray(key)
        case .inviteCode:
            return loadString(key)
        }
    }
    func loadString(_ key: Key) -> String? {
        return defaults.object(forKey: key.rawValue) as? String
    }
    func loadBool(_ key: Key) -> Bool? {
        return defaults.object(forKey: key.rawValue) as? Bool
    }
    func loadInt(_ key: Key) -> Int? {
        return defaults.integer(forKey: key.rawValue)
    }
    func loadIntArray(_ key: Key) -> [Int]? {
        return defaults.object(forKey: key.rawValue) as? [Int]
    }
    func save( value: Any, forkey key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func delete(_ key: Key) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
