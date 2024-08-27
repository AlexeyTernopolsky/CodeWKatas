//
//  Codewars_KataTests.swift
//  Codewars KataTests
//
//  Created by Alexey Ternopolsky on 26.02.2023.
//

import XCTest
@testable import Codewars_Kata

final class Codewars_KataTests: XCTestCase {
    
    func dotest(_ nb: Int, _ exp: Double) {
        var inrange: Bool; let merr: Double = 1e-12; var e: Double;
        let actu = Kyu5_2.one.exEuler(nb)
        e = abs(actu - exp)
        inrange = (e <= merr)
        if inrange == false {
            print(String(format:"Expected should be near: %.12f", exp));
            print(String(format:"but got: %.12f", actu))
        }
        XCTAssertEqual(inrange, true)
    }
    
    func testExample() {
        dotest(1, 0.5)
        dotest(10, 0.026314)
        dotest(17, 0.015193)
        
    }
    
}
