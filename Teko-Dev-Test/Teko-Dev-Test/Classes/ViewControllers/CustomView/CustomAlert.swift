//
//  CustomAlert.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/7/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

class CustomDialog {
    
    private static let customDialog = CustomDialog()
    
    private init() {
        
    }
    
    public static func shared() -> CustomDialog {
        return customDialog
    }
    
    func showSimpleAlert(title: String = "Phong Vũ", message: String, currentVC: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        currentVC.present(alert, animated: true)
    }
    
    func showAlertTwoOption(title: String = "Phong Vũ", message: String, currentVC: UIViewController, completed: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            completed()
        }))
        
        currentVC.present(alert, animated: true)
    }
    
}
