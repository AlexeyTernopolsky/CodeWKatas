//
//  FlipYourStack_6kyu.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 30.06.2024.
//

import Foundation

// Task: Flip Your Stack (of Pancakes)
// Ref: 6472390e0d0bb1001d963536
extension Array<Int> {
    mutating func oneFlipFromIndex(_ index: Int) {
        guard index > 0 && index < count else { return }
        var changes = self
        for i in stride(from: index, through: 0, by: -1) {
            changes[i] = self[index - i]
        }
        self = changes
    }
    
    func maxIndex(lastBorder: Int) -> Int {
        var max = Int.min
        var maxIndex = -1
        for index in 0...lastBorder {
            if max <= self[index] {
                max = self[index]
                maxIndex = index
            }
        }
        return maxIndex
    }
}

func flipPancakes(stack: [Int]) -> [Int] {
    var result = [Int]()
    guard stack.count > 1 else { return result }
    var opStack = stack
    for index in stride(from: opStack.count - 1, to: 0, by: -1) {
        let minIndex = opStack.maxIndex(lastBorder: index)
        switch minIndex {
        case 0:
            opStack.oneFlipFromIndex(index)
            result.append(index)
        case index: break
        default:
            opStack.oneFlipFromIndex(minIndex)
            opStack.oneFlipFromIndex(index)
            result.append(minIndex)
            result.append(index)
        }
    }
    return result
}
