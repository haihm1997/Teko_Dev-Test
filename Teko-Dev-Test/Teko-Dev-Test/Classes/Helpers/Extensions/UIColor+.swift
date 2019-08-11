//
//  UIColor+.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha
                )
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
    
    static var tomato: UIColor {
        return UIColor(red: 234, green: 52, blue: 31)
    }
    
    static var coolGrey: UIColor {
        return UIColor(red: 143, green: 149, blue: 152)
    }
    
    static var darkGrey: UIColor {
        return UIColor(red: 38, green: 40, blue: 41)
    }
    
    static var tomatoTwo: UIColor {
        return UIColor(red: 223, green: 32, blue: 32)
    }
    
    static var reddishOrange: UIColor {
        return UIColor(red: 245, green: 71, blue: 30)
    }
    
    static var paleGrey: UIColor {
        return UIColor(red: 238, green: 241, blue: 243)
    }
    
    static var pumpkinOrange: UIColor {
        return UIColor(red: 245, green: 132, blue: 0)
    }
    
}
