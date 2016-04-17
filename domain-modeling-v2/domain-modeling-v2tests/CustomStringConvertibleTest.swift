//
//  CustomStringConvertibleTest.swift
//  domain-modeling-v2
//
//  Created by apple on 4/16/16.
//  Copyright © 2016 apple. All rights reserved.
//

import XCTest

import domain_modeling_v2

class CustomStringConvertibleTest: XCTestCase {
    let threeEUR = Money(amount: 3, currency: "EUR");
    let supermanHourly = Job(title: "Superman", type: Job.JobType.Hourly(10.0));
    var nickJackson = Person(firstName : "Nick", lastName: "Jackson", age : 21);
    let cathyJackson = Person(firstName : "Cathy", lastName: "Jackson", age : 20);
    
    func testMoneyDescription() {
        let moneyprint = threeEUR.description;
        XCTAssert(moneyprint == "EUR3.0");
    }
    
    func testJobDescription() {
        let jobprint = supermanHourly.description;
        XCTAssert(jobprint == "Superman: 10h.0 per hour");
    }
    
    func testPersonDescription() {
        var personprint = nickJackson.description;
        XCTAssert(personprint == "Nick Jackson 21");
        nickJackson.job = supermanHourly;
        personprint = nickJackson.description;
        XCTAssert(personprint == "Nick Jackson 21 job: Superman: 10.0 per hour");
        nickJackson.spouse = cathyJackson;
        personprint = nickJackson.description;
        XCTAssert(personprint == "Nick Jackson 21 job: Superman: 10.0 per hour spouse: Cathy Jackson");
    }
    
    func testFamilyDescription() {
        var family = Family(spouse1: nickJackson, spouse2: cathyJackson);
        var familyprint = family.description
        XCTAssert(familyprint == "Nick Jackson 21 job: Superman: 10.0 per hour spouse: Cathy Jackson; Cathy Jackson spouse: Nick Jackson");
        var child = family.haveChild(Person(firstName: "Peter", lastName: "Jackson", age: 2));
        familyprint = family.description;
        XCTAssert(familyprint == "Nick Jackson 21 job: Superman: 10.0 per hour spouse: Cathy Jackson; Cathy Jackson spouse: Nick Jackson; Peter Jackson 2");
    }

}
