//
//  UserDefaultsManager.swift
//  Uni
//
//  Created by 류창휘 on 2023/07/17.
//

import Foundation

enum Key: String {
    case hasOnboarded
    case hasCoupleCode
    case isAlreadyFinish
    case lastRoundId
    case userId
    case partnerId
}

class UserDefaultsManager {
    
    let defaults = UserDefaults.standard
    static let shared = UserDefaultsManager()
    private init() {}
    
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
    
    func load(_ key: Key) -> Any? {
        switch key {
        case .hasOnboarded:
            return loadBool(key)
        case .hasCoupleCode:
            return loadBool(key)
        case .isAlreadyFinish:
            return loadBool(key)
        case .lastRoundId:
            return loadInt(key)
        case .userId:
            return loadInt(key)
        case .partnerId:
            return loadInt(key)
        }
    }
    
    func loadBool(_ key: Key) -> Bool? {
        return defaults.object(forKey: key.rawValue) as? Bool
    }
    
    func loadInt(_ key: Key) -> Int? {
        return defaults.integer(forKey: key.rawValue)
    }
    
    func save( value: Any, forkey key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func delete(_ key: Key) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
