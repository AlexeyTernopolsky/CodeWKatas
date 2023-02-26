//
//  Codewars_KataTests.swift
//  Codewars KataTests
//
//  Created by Alexey Ternopolsky on 26.02.2023.
//

import XCTest
@testable import Codewars_Kata

final class Codewars_KataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let actual = [2,3]
        XCTAssertEqual(actual, Kyu6_1.Solution.twosum(numbers: [1,54,24,35], target: 59))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
