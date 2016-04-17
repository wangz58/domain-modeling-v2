//
//  ExtensionTest.swift
//  domain-modeling-v2
//
//  Created by apple on 4/16/16.
//  Copyright © 2016 apple. All rights reserved.
//

import XCTest

import domain_modeling_v2

class ExtensionTest: XCTestCase {
    
    let numD: Double = 3.12;
    
    func testDoubleToMoney() {
        var numMoney = numD.USD;
        XCTAssert(numMoney.amount == 3)
        XCTAssert(numMoney.currency == "USD")
        numMoney = numD.EUR;
        XCTAssert(numMoney.amount == 2)
        XCTAssert(numMoney.currency == "USD")
        numMoney = numD.CAN;
        XCTAssert(numMoney.amount == 2)
        XCTAssert(numMoney.currency == "USD")
        numMoney = numD.GBP;
        XCTAssert(numMoney.amount == 6)
        XCTAssert(numMoney.currency == "USD")
    }

}
