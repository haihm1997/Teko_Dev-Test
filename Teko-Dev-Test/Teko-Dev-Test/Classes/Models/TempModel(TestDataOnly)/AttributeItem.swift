//
//  CategoryItem.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/8/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation

// using for fake data
class AttributeItem: NSObject {
    
    var index = 0
    var name = ""
    var value = ""
    
    override init() {
        super.init()
    }
    
    init(index: Int, name: String, value: String) {
        self.index = index
        self.name = name
        self.value = value
    }
    
}
