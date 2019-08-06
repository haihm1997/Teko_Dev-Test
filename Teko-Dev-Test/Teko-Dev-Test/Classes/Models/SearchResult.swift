//
//  SearchResult.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/7/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchResult: NSObject {
    
    var products: [SearchItem] = [SearchItem]()
    
    override init() {
        super.init()
    }
    
    init(_ json: JSON) {
        self.products = json["products"].arrayValue.map({SearchItem($0)})
    }
    
}
