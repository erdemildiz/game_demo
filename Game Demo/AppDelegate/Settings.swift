//
//  Settings.swift
//  Game Demo
//
//  Created by Erdem ILDIZ on 1.01.2021.
//

import SpriteKit

struct AppSetting {
    static let stageBgColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1)
}

struct PhysicsCategories {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1        // 01
    static let switchCategory: UInt32 = 0x1 << 1 // 10
}

struct ZPosition {
    static let label: CGFloat       = 0
    static let ball: CGFloat        = 1
    static let colorSwitch: CGFloat = 2
}
