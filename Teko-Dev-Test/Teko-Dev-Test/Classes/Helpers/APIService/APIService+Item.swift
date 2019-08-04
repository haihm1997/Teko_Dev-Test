//
//  APIService+Item.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

class ItemRouter: BaseRequest {
    
    enum EndPoint {
        case search([String: Any])
    }
    
    var endPoint: EndPoint
    
    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }
    
    override var method: HTTPMethod {
        switch endPoint {
        case .search:
            return .get
        }
    }
    
    override var parameters: [String : Any]? {
        switch endPoint {
        case .search(let param):
            return param
        }
    }
    
    override var path: String {
        switch endPoint {
        case .search:
            return Address.Search.searchItem
        }
    }
    
}

extension APIService {
    static func searchItem(_ params: [String: Any]) -> Observable<APIResponse> {
        return request(ItemRouter(endPoint: .search(params)))
    }
}
