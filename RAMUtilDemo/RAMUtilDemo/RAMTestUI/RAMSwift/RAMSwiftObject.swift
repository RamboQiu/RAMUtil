//
//  RAMSwiftObject.swift
//  RAMUtilDemo
//
//  Created by rambo on 2020/1/21.
//  Copyright © 2020 裘俊云. All rights reserved.
//

import UIKit

class RAMSwiftObject: NSObject {
    
    func test() -> Void {
        
    }
    
    func greet(person: String = "Tom") -> String {
        let greeting = "Hello, " + person + "!"
        return greeting
    }
    
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let tmp = a;
        a = b;
        b = tmp;
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    override init() {
        super.init();
        print(arithmeticMean(1, 2, 3, 4, 5));
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        var reversedNames = names.sorted { (_ s1: String, _ s2: String) -> Bool in
            return s1 > s2
        }
        print(reversedNames)
    }
}
