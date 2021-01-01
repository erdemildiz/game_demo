//
//  Storage.swift
//  Game Demo
//
//  Created by Erdem ILDIZ on 1.01.2021.
//

import Foundation

@propertyWrapper
struct Storage <T> {
    
    let key: String
    let defaultValue: T
    
    let userDefault: UserDefaults = .standard
    
    var wrappedValue: T {
        get {
            return userDefault.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefault.set(newValue, forKey: key)
        }
    }
}
