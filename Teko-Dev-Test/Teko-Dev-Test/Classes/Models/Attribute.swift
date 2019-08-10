//
//  Attribute.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/10/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation
import SwiftyJSON

class Attribute: NSObject {
    
    var index = 0
    var name = ""
    var value = ""
    
    override init() {
        super.init()
    }
    
    init(index: Int, json: JSON) {
        print("attribute index: \(index)")
        self.index = index
        self.name = json["name"].stringValue
        self.value = json["value"].stringValue
    }
    
}
