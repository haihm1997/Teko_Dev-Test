//
//  UITableView+.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T>(ofType type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T
    }
    
}
