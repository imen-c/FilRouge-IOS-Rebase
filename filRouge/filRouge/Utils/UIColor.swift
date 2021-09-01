//
//  UIColor.swift
//  filRouge
//
//  Created by Anthony on 01/07/2021.
//

import UIKit

extension UIColor {
    
    @nonobjc class var blueGrey: UIColor {
        return UIColor(hex: "#ececf5")
    }
    
    @nonobjc class var darkblue: UIColor {
        return UIColor(hex: "#000c37")
    }
    
    @nonobjc class var pink: UIColor {
        return UIColor(hex: "#ec7082")
    }
    
    @nonobjc class var middleBlue: UIColor {
        return UIColor(hex: "#001251")
    }
    
    @nonobjc class var turquoise_blue: UIColor {
        return UIColor(hex: "#02aab0")
    }
    
    @nonobjc class var aquamarine: UIColor {
        return UIColor(hex: "#00cdac")
    }
    
    @nonobjc class var coral: UIColor {
        return UIColor(hex: "#eb5757")
    }
    
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
