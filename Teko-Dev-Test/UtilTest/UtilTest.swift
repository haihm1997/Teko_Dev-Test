//
//  UtilTest.swift
//  UtilTest
//
//  Created by Hoàng Hải on 8/11/19.
//  Copyright © 2019 HoangHai. All rights reserved.
//

import XCTest
@testable import Teko_Dev_Test

class UtilTest: XCTestCase {

    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToCurrencyFormat() {
        let inputNumber: Float = 1500000.0
        let result = Utils.toCurrencyFormat(inputNumber)
        
        let expectResult = "1.500.000"
        
        XCTAssertEqual(expectResult, result)
    }

}
