//
//  APIService.swift
//  Teko-Dev-Test
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

struct APIService {
    
    static func request(_ urlRequest: BaseRequest) -> Observable<APIResponse> {
        return Observable.create({ observer in
            _ = RxAlamofire.request(urlRequest).responseJSON().subscribe(onNext: { response in
                observer.onNext(APIResponse(response))
                observer.onCompleted()
            }, onError: { error in
                _ = APIResponse(error)
                observer.onError(error)
            })
            return Disposables.create()
        })
    }
    
}
