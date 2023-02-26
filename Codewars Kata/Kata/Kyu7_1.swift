//
//  Kyu7_1.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 26.02.2023.
//

import Foundation

enum Kyu7_1 {
    // Task: Flatten and sort an array
    // Ref: 57ee99a16c8df7b02d00045f
    func flattenAndSort<T: Comparable>(_ arr: [[T]]) -> [T] {
        arr.reduce([T](), +).sorted()
    }
}
