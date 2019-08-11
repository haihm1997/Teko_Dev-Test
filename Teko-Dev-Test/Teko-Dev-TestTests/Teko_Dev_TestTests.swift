//
//  Teko_Dev_TestTests.swift
//  Teko-Dev-TestTests
//
//  Created by Hoàng Hải on 8/4/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import XCTest
@testable import Teko_Dev_Test

class Teko_Dev_TestTests: XCTestCase {

    let product = Product()
    
    override func setUp() {
        product.discount = 100000
        product.price.sellPrice = 1000000
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculateDiscount() {
        let result = product.calculateDiscountPercent()
        
        let expectResult = 10
        
        XCTAssertEqual(result, expectResult)
    }

}
