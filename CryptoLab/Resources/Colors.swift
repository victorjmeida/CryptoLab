//
//  Colors.swift
//  CryptoLab
//
//  Created by João VIctir da Silva Almeida on 07/07/25.
//

import UIKit

private extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8)  / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

public extension UIColor {
    static let primaryColor    = UIColor(named: "primaryColor")    ?? UIColor(hex: 0x5E5CE6)
    static let buttonColor     = UIColor(named: "buttonColor")     ?? UIColor(hex: 0xF67022)
    static let backgroundColor = UIColor(named: "backgroundColor") ?? UIColor(hex: 0xF5F6FA)
    static let textPrimary     = UIColor(named: "textPrimary")     ?? UIColor(hex: 0x1B1B1B)
    static let textSecondary   = UIColor(named: "textSecondary")   ?? UIColor(hex: 0x6B6B70)
    static let separator       = UIColor(named: "separator")       ?? UIColor(hex: 0xDADAE2)
}


