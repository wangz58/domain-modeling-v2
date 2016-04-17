//
//  MathematicsTest.swift
//  domain-modeling-v2
//
//  Created by apple on 4/16/16.
//  Copyright © 2016 apple. All rights reserved.
//
import Foundation

import XCTest;

import domain_modeling_v2;

class MathematicsTest: XCTestCase {
    
    let threeEUR = Money(amount: 3, currency: "EUR");
    let fiveEUR = Money(amount: 5, currency: "EUR");
    let threeUSD = Money(amount: 3, currency: "USD");
    let tenCAN = Money(amount: 10, currency: "CAN")

    func testAddEURtoEUR() {
        let total = threeEUR.add(fiveEUR)
        XCTAssert(total.amount == 8)
        XCTAssert(total.currency == "EUR")
    }
    
    func testAddUSDtoCAN() {
        let total = threeUSD.add(tenCAN)
        XCTAssert(total.amount == 14)
        XCTAssert(total.currency == "CAN")
    }
    
    func testSubtractEURfromEUR() {
        let total = fiveEUR.subtract(threeEUR)
        XCTAssert(total.amount == 2)
        XCTAssert(total.currency == "EUR")
    }
    
    func testSubtractUSDfromCAN() {
        let total = threeUSD.subtract(tenCAN)
        XCTAssert(total.amount == 6)
        XCTAssert(total.currency == "CAN")
    }

}
