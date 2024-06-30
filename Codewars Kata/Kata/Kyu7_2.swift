//
//  Kyu7_2.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 30.06.2024.
//

import Foundation

enum Kyu7_2 {
    // Task: Sum of two lowest positive integers
    // Ref: 558fc85d8fd1938afb000014
    func sumOfTwoSmallestIntegersIn(_ array: [Int]) -> Int {
        array.sorted().prefix(2).reduce(0, +)
    }
    
    // Task: Is It Negative Zero (-0)?
    // Ref: 5c5086287bc6600001c7589a
    func isNegativeZero(_ n: Float) -> Bool {
        n.isZero && n.sign == .minus
    }
    
    // Task: Billiards triangle
    // Ref: 5bb3e299484fcd5dbb002912
    func pyramid(_ balls: Int) -> Int{
        var currentLevel = 1
        var remainder = balls
        while remainder >= currentLevel {
            currentLevel += 1
            remainder -= currentLevel
        }
        return currentLevel - (remainder <= 0 ? 1 : 0)
    }
    
    // Task: Lost number in number sequence
    // Ref: 595aa94353e43a8746000120
    func findDeletedNumber(_ array: [Int], _ mixArray: [Int]) -> Int {
        let set = Set(mixArray)
        for i in array {
            if !set.contains(i) {
                return i
            }
        }
        return 0
    }
    
    // Task: Doubleton number
    // Ref: 604287495a72ae00131685c7
    func doubleton(_ num: Int) -> Int {
        ((num + 1)...).first { number in Set(String(number).map { $0 }).count == 2 } ?? 0
    }
    
    // Task: Sort Out The Men From Boys
    // Ref: 5af15a37de4c7f223e00012d
    func menFromBoys(_ arr: [Int]) -> [Int] {
        let nonDublicates = Array(Set(arr))
        let evenNumbers = nonDublicates.filter { $0 % 2 == 0 }.sorted()
        let oddNumbers = nonDublicates.filter { abs($0) % 2 == 1 }.sorted().reversed()
        return evenNumbers + oddNumbers
    }
    
    // Task: Stacked Balls - 2D
    // Ref: 5bb804397274c772b40000ca
    func stackHeight2D(_ layers: Int) -> Double {
        guard layers > 0 else { return 0.0 }
        return 1.0 + Double(layers - 1) * 0.866025403784439
    }
    
    // Task: Odder Than the Rest
    // Ref: 5983cba828b2f1fd55000114
    func oddOne(_ arr: [Int]) -> Int? {
        arr.firstIndex { $0 % 2 != 0 }
    }
    
    // Task: Linked Lists - Append
    // Ref: 55d17ddd6d7868493e000074
    class Node {
        var data: Int
        var next: Node?
        init(_ data: Int) {
            self.data = data
        }
    }
    
    func append(_ listA:Node?, _ listB:Node?) -> Node? {
        guard let listA else { return listB }
        guard let listB else { return listA }
        var pointer = listA
        while pointer.next != nil {
            if let nextNode = pointer.next {
                pointer = nextNode
            }
        }
        pointer.next = listB
        return listA
    }
    
    // Task: Euclidean distance in n dimensions
    // Ref: 595877be60d17855980013d3
    func euclideanDistanceBetween(_ point1: [Double], and point2: [Double]) -> Double {
        var sum = 0.0
        for index in point1.indices {
            let distance = point1[index] - point2[index]
            sum += distance * distance
        }
        return round(sqrt(sum) * 100.0) / 100.0
    }
    
    // Task: Linked Lists - Move Node
    // Ref: 55da347204760ba494000038
    struct Context {
        var source:Node?
        var dest:Node?
    }
    
    func moveNode(source:Node?, dest:Node?) throws -> Context? {
        guard let source else { throw "Nil source" }
        let newSource = source.next
        source.next = dest
        return Context(source: newSource, dest: source)
    }
    
    // Task: Leap Years
    // Ref: 526c7363236867513f0005ca
    func isLeapYear(_ year: Int) -> Bool {
        year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
    }
    
    // Task: Sum of angles
    // Ref: 5a03b3f6a1c9040084001765
    func angle(_ n: Int) -> Int {
        180 * (n - 2)
    }
    
    // Task: Maximum Multiple
    // Ref: 5aba780a6a176b029800041c
    func maxMultiple(_ d: Int, _ b: Int) -> Int {
        b / d * d
    }
    
    // Task: Don't give me five!
    // Ref: 5813d19765d81c592200001a
    func dontGiveMeFive(_ start: Int, _ end: Int) -> Int {
        (start...end).reduce(0) { acc, element in acc + (String(element).contains("5") ? 0 : 1) }
    }
    
    // Task: Sum of odd numbers
    // Ref: 55fd2d567d94ac3bc9000064
    func rowSumOddNumbers(_ row: Int) -> Int {
        guard row > 1 else { return 1}
        let firstInRow = (row - 1) * row + 1
        let lastInRow = firstInRow + (row - 1) * 2
        return (firstInRow + lastInRow) * row / 2
    }
    
    // Task: Special Number (Special Numbers Series #5)
    // Ref: 5a55f04be6be383a50000187
    func specialNumber(_ number: Int) -> String {
        String(number).contains { "6789".contains($0) } ? "NOT!!" : "Special!!"
    }
    
    // Task: Disarium Number (Special Numbers Series #3)
    // Ref: 5a53a17bfd56cb9c14000003
    func disariumNumber(_ number: Int) -> String {
        var position = 0
        
        let sum = String(number).reduce(0) { acc, element in
            position += 1
            let digit = element.wholeNumberValue ?? 0
            return acc + (1...position).reduce(1) { mult, _ in  mult * digit }
        }
        return sum == number ? "Disarium !!" : "Not !!"
    }
    
    // Task: Jumping Number (Special Numbers Series #4)
    // Ref: 5a54e796b3bfa8932c0000ed
    func jumpingNumber(_ number: Int) -> String {
        var jumping = "Jumping!!"
        var prev: Int?
        String(number).compactMap{ $0.wholeNumberValue }.forEach {
            if let prev, abs(prev - $0) != 1 {
                jumping = "Not!!"
            }
            prev = $0
        }
        return jumping
    }
    
    // Task: Moves in squared strings (I)
    // Ref: 56dbe0e313c2f63be4000b25
    func horMirror(_ s: String) -> String {
        s.split(separator: "\n").reversed().joined(separator: "\n")
    }
    func vertMirror(_ s: String) -> String {
        s.split(separator: "\n").map { String($0.reversed()) }.joined(separator: "\n")
    }
    // replace the dots with function parameter
    func oper(_ operation:(String)->String, _ s: String) -> String {
        operation(s)
    }
}
