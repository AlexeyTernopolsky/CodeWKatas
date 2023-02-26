//
//  Kyu5_1.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 26.02.2023.
//

import Foundation

enum Kyu5_1 {
    // Task: Perimeter of squares in a rectangle
    // Ref: 559a28007caad2ac4e000083
    func perimeter(_ n: UInt64) -> UInt64 {
        var prevOne: UInt64?
        var prevTwo: UInt64?
        var sum: UInt64 = 0
        for i in 0...n {
            let cur = i < 2 ? 1 : prevOne! + prevTwo!
            sum += cur
            prevTwo = prevOne
            prevOne = cur
        }
        
        return sum * 4
    }
}
