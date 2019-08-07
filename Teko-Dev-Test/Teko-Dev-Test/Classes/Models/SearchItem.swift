//
//  SearchItem.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/7/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchItem: NSObject {
    
    var id = ""
    var thumbnailUrl = ""
    var name = ""
    var price = Price()
    var discount: Float = 0
    var discountPercent = 0
    
    override init() {
        super.init()
    }
    
    init(id: String, thumbnailUrl: String, name: String, price: Price, discount: Float = 0, discountPercent: Int = 0) {
        self.id = id
        self.thumbnailUrl = thumbnailUrl
        self.name = name
        self.price = price
        self.discount = discount
        self.discountPercent = discountPercent
    }
    
    init(_ json: JSON) {
        self.id = json["sku"].stringValue
        self.name = json["name"].stringValue
        self.price = Price(json["price"])
        self.discountPercent = json["promotionPrices"].arrayValue.isEmpty ? 0 : 1
        for item in json["promotionPrices"].arrayValue {
            self.discount += item["promotionPrice"].floatValue
        }
        if self.price.sellPrice != 0 {
            let calculatedDiscountPercent = Int((self.discount / self.price.sellPrice) * 100)
            self.discountPercent = calculatedDiscountPercent <= 100 ? calculatedDiscountPercent : 0
        } else {
            self.discountPercent = 0
        }
        self.price.sellPrice -= self.discount
        self.thumbnailUrl = json["images"].arrayValue.first?.dictionaryObject?["url"] as? String ?? ""
        print("Thumbnail image: \(thumbnailUrl)")
    }
    
}

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

class Promotion: NSObject {
    
}
