//
//  Utils.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/7/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation

class Utils: NSObject {
    
    static func toCurrencyFormat(_ input: Float) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "vi")
        let currencyStr = currencyFormatter.string(from: NSNumber(value: input))
        return currencyStr?.components(separatedBy: ",").first ?? "0"
    }
    
}
