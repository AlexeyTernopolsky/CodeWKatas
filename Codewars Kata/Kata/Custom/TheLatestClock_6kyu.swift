//
//  TheLatestClock_6kyu.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 29.08.2024.
//

import Foundation

// Task: The latest clock
// Ref: 58925dcb71f43f30cd00005f
extension Array {
    func allSamples() -> [[Element]] {
        guard count > 0 else { return [] }
        guard count > 1 else { return [self] }
        var result = [[Element]]()
        for i in indices {
            var copy = self
            copy.remove(at: i)
            for subSequence in copy.allSamples() {
                var anotherSnap = [Element]()
                anotherSnap.append(self[i])
                anotherSnap.append(contentsOf: subSequence)
                result.append(anotherSnap)
            }
        }
        return result
    }
}

struct Clock {
    let h1: Int
    let h2: Int
    let m1: Int
    let m2: Int
    var isValid: Bool {
        let hours = h1 * 10 + h2
        let minutes = m1 * 10 + m2
        return hours >= 0 && hours <= 23 && minutes >= 0 && minutes <= 59
    }
    var value: Int { (h1 * 10 + h2) * 60 + m1 * 10 + m2 }
    var description: String { "\(h1)\(h2):\(m1)\(m2)" }
}

func latestClock(_ a: Int, _ b: Int, _ c: Int, _ d: Int) -> String {
    let max = [a, b, c, d].allSamples().compactMap {
        let item = Clock(h1: $0[0], h2: $0[1], m1: $0[2], m2: $0[3])
        return item.isValid ? item : nil
    }.max(by: { $0.value < $1.value })
    return max?.description ?? ""
}
