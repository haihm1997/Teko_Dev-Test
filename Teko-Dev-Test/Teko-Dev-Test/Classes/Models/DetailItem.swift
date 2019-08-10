//
//  DetailItem.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/10/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation
import SwiftyJSON

class DetailItem: NSObject {
    
    var attributeList = [Attribute]()
    var seoInfo = ""
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        self.attributeList = json["attributeGroups"].arrayValue.enumerated().map({ (index, element) in
            Attribute(index: index, json: element)
        })
        self.seoInfo = json["seoInfo"]["description"].stringValue
    }
    
}
