//
//  UIApplication+.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/6/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
