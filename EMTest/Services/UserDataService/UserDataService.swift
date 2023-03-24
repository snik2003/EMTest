//
//  UserDataService.swift
//  EMTest
//
//  Created by Сергей Никитин on 14.03.2023.
//

import Foundation

fileprivate enum UserDataKey: String {
    case loggedInUserIdKey
    case userFullNameKey
    case userBalanceKey
}

protocol UserDataServiceProtocol {
    var loggedInUserId: String? { get set }
    var userFullName: String { get set }
    var userBalance: Double { get set }
}

final class UserDataService {
    
    private let userDefaults: UserDefaults
        
    init() {
        userDefaults = UserDefaults.standard
    }
}

extension UserDataService {
    
    fileprivate func value(for key: UserDataKey) -> String? {
        return userDefaults.object(forKey: key.rawValue) as? String
    }
    
    fileprivate func anyValue(for key: UserDataKey) -> Any? {
        return userDefaults.object(forKey: key.rawValue)
    }
    
    fileprivate func setValue(_ value: Any?, for key: UserDataKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }
}

extension UserDataService: UserDataServiceProtocol {
    
    var loggedInUserId: String? {
        get { return value(for: .loggedInUserIdKey) }
        set { setValue(newValue, for: .loggedInUserIdKey) }
    }
    
    var userFullName: String {
        get { return value(for: .userFullNameKey) ?? "Satria Adhi Pradana" }
        set { setValue(newValue, for: .userFullNameKey) }
    }
    
    var userBalance: Double {
        get { return anyValue(for: .userBalanceKey) as? Double ?? 1593 }
        set { setValue(newValue, for: .userBalanceKey) }
    }
}
