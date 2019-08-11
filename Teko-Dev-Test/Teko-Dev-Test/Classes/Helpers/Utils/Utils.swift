//
//  Utils.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/7/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    static func toCurrencyFormat(_ input: Float) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "vi")
        let currencyStr = currencyFormatter.string(from: NSNumber(value: input))
        return currencyStr?.components(separatedBy: ",").first ?? "0"
    }
    
    static func makeGradientForView(_ parentView: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = parentView.bounds
        gradientLayer.colors =  [UIColor.tomatoTwo.cgColor, UIColor.reddishOrange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.cornerRadius = parentView.layer.cornerRadius
        parentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
