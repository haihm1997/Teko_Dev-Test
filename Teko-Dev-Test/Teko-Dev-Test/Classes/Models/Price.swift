//
//  Price.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/10/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation
import SwiftyJSON

class Price: NSObject {
    
    var supplierSalePrice: Float = 0
    var sellPrice: Float = 0
    
    override init() {
        super.init()
    }
    
    init(_ json: JSON) {
        self.supplierSalePrice = json["supplierSalePrice"].floatValue
        self.sellPrice = json["sellPrice"].floatValue
    }
    
}
