//
//  UIScreen+.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/6/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

extension UIScreen {
    
    class var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    class var bottomSpace: CGFloat {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.bottom ?? 0
    }
    
    class var statusBarHeight: CGFloat {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.top ?? 0
    }
    
}
