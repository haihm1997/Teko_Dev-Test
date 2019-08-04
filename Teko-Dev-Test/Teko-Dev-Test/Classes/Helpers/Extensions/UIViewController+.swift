//
//  UIViewController+.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit
import SVProgressHUD

enum StoryboardName: String {
    case main = "Main"
}

extension UIViewController {
    
    func showLoading(message: String = "", isShowMask: Bool = false) {
        if isShowMask {
            SVProgressHUD.setDefaultMaskType(.clear)
        }
        if !message.isEmpty {
            SVProgressHUD.show(withStatus: message)
        } else {
            SVProgressHUD.show()
        }
    }
    
    @objc func dismissLoading() {
        SVProgressHUD.dismiss()
    }
    
}

extension UIViewController {
    
    func instantiateViewController<T>(fromStoryboard name: StoryboardName, ofType type: T.Type) -> T {
        return UIStoryboard(name: name.rawValue, bundle: nil).instantiateViewController(ofType: type)
    }
    
}
