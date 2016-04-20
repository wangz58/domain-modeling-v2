//
//  main.swift
//  domain-modeling-v2
//
//  Created by apple on 4/16/16.
//  Copyright © 2016 apple. All rights reserved.
//

import Foundation

print("Hello, World");

public func testMe() -> String {
    return "I have been tested"
}

public class TestMe {
    public func Please() -> String {
        return "I have been tested"
    }
}

public protocol CustomStringConvertible {
    var description: String { get };
}

public protocol Mathematics {
    func add(to: Money) -> Money;
    func subtract(from: Money) -> Money;
}

/////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics { // open1
    public var amount : Int
    public var currency : String
    
    public init(amount: Int, currency: String) {
        self.amount = amount;
        self.currency = currency;
    }
    

    
    public func convert(to: String) -> Money { // open3
        //    1 USD = .5 GBP (2 USD = 1 GBP) 1 USD = 1.5 EUR (2 USD = 3 EUR) 1 USD = 1.25 CAN (4 USD = 5 CAN)
        var result = Money(amount: self.amount, currency: self.currency);
        if (result.currency != to) { // open4
            if (result.currency == "USD" || result.currency == "EUR" || result.currency == "CAN" || result.currency == "GBP")  { //open5
                if (result.currency != "USD") { // open6
                    if (result.currency == "GBP") { //open7
                        result.amount = result.amount * 2;
                    } else if (result.currency == "EUR") {
                        result.amount = result.amount / 3 * 2;
                    } else {
                        result.amount = result.amount / 5 * 4;
                    } // close7
                    result.currency = "USD";
                } // close6
                if (to != "USD") { //open8
                    if (to == "GBP") { // open9
                        result.amount = result.amount / 2;
                        result.currency = to;
                    } else if (to == "EUR") {
                        result.amount = result.amount * 3 / 2;
                        result.currency = to;
                        print("%%%%%%%%%%%\(result.amount) \(result.currency)%%%%%%%%%%%");
                    } else {
                        result.amount = result.amount * 5 / 4;
                        result.currency = to;
                    } // close9
                } //close8
            } // close5
        } // close4
        return result;
    } // close3
    
    public func add(to: Money) -> Money {
        var result = Money(amount: self.amount, currency: self.currency);
        if (result.currency != to.currency) {
            result = result.convert(to.currency)
        }
        result.amount = result.amount + to.amount;
        return result;
    }
    
    public func subtract(from: Money) -> Money {
        var result = Money(amount: self.amount, currency: self.currency);
        if (result.currency != from.currency) {
            result = result.convert(from.currency)
        }
        result.amount = from.amount - result.amount;
        return result;
    }
    
    public var description: String { // open2
        return "\(currency)\(Double(amount))";
    } // close2
} // close1

////////////////////////////////////
// Job
//
public class Job: CustomStringConvertible {
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    public var title : String
    public var type : JobType
    
    public init(title : String, type : JobType) {
        self.title = title;
        self.type = type;
    }
    
    public var description: String {
        get {
        switch self.type {
        case .Hourly(let x):
            return "\(title): \(x) per hour"
        case .Salary(let y):
            return "\(title): \(y) per year"
        }
        }
    }
    
    public func calculateIncome(hours: Int) -> Int {
        switch self.type {
        case .Hourly(let num) :
            let result = num * Double(hours);
            return Int(result);
        case .Salary(let num) :
            return num;
        }
    }
    
    public func raise(amt : Double) {
        switch self.type {
        case .Hourly(let num) :
            self.type = JobType.Hourly(num + amt);
        case .Salary(let num) :
            self.type = JobType.Salary(num + Int(amt));
        }
    }
}

////////////////////////////////////
// Person
//
public class Person: CustomStringConvertible {
    public var firstName : String = ""
    public var lastName : String = ""
    public var age : Int = 0
    private var _job : Job? = nil;
    private var _spouse : Person? = nil;
    
    public var description: String {
        var desc = "\(firstName) \(lastName) \(age)";
        if (self.job != nil) {
            desc += " job: \(job!.description)"
        }
        if (self.spouse != nil) {
            desc += " spouse: \(spouse!.firstName) \(spouse!.lastName)"
        }
        return desc;
    }
    
    public var job : Job? {
        get {return self._job}
        set(newJob) {
            if (self.age >= 16) {
                self._job = newJob;
            }
        }
    }
    
    public var spouse : Person? {
        get {return self._spouse}
        set(newSpouse) {
            if (age >= 18) {
                self._spouse = newSpouse;
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    public func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job) spouse:\(self.spouse)]";
    }
}

////////////////////////////////////
// Family
//
public class Family: CustomStringConvertible {
    private var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2;
            spouse2.spouse = spouse1;
        }
        members.append(spouse1);
        members.append(spouse2);
    }
    
    public var description: String {
        var desc = "";
        for person in self.members {
            desc += person.description + "; ";
        }
        return desc;
    }
    
    
    public func haveChild(child: Person) -> Bool {
        var check: Bool = false;
        var i = 0;
        repeat {
            if (members[i].age >= 21) {
                check = true;
            }
            i = i+1;
        } while(i < members.count)
        if (check) {
            members.append(child);
            return true;
        } else {
            return false;
        }
    }
    
    public func householdIncome() -> Int {
        var result: Int = 0;
        var i = 0;
        repeat {
            if (members[i].job != nil) {
                switch members[i].job!.type {
                case .Hourly(let num) :
                    result = result + Int(num*2000);
                case .Salary(let num) :
                    result = result + num;
                }
            }
            i = i+1;
        } while(i < members.count)
        return result;
    }
}

public extension Double {
    var USD: Money { return Money(amount: Int(self), currency: "USD")}
    var EUR: Money { return Money(amount: Int(self / 3 * 2), currency: "USD")}
    var GBP: Money { return Money(amount: Int(self * 2), currency: "USD")}
    var CAN: Money { return Money(amount: Int(self / 5 * 4), currency: "USD")}
}


