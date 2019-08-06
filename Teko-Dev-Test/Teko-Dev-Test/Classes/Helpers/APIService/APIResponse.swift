//
//  APIResponse.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SVProgressHUD
import SwiftyJSON

enum APIStatus: Int {
    case success = 0
    case failed = 1
    case error = 2
    case none = 3
    case empty = 4
    
    static func rawValue(_ value: Int) -> APIStatus {
        switch value {
            case 0: return .success
            case 1: return .failed
            case 2: return .error
            case 3: return .none
            case 4: return .empty
            default: return .none
        }
    }
}

struct APIResponse {
    var message: String = ""
    var result: Any?
    var data = [String: Any]()
    var code: String = ""
    
    init(_ response: DataResponse<Any>) {
        print("RESULT: \(String(describing: response.result.value))")
        if let value = response.result.value as? [String: Any] {
            self.result = value
            
            if let code = value["code"] as? String {
                self.code = code
            }
            
            if let dict = value["result"] as? [String: Any] {
                self.data = dict
            }
        }
        handlerTockenExpire()
    }
    
    init(_ error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func handlerTockenExpire() {
        if let value = self.result as? [String: Any],
            let _ = value["Message"] as? String {
            SVProgressHUD.dismiss()
        }
    }
}

