//
//  APIConfigs.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation

struct Address {

    static let baseUrl = "https://listing-stg.teko.vn/api/"
    
    struct Search {
        static let searchItem = "search/"
    }
    
}

struct APICode {
    static let API_CODE_OK                            = "000"
    static let API_CODE_FAIL                          = "999"
    static let API_TOKEN_EXPIRE                       = "9999"
}
