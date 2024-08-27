//
//  CuckooClock_6kyu.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 29.08.2024.
//

import Foundation

// Task: Cuckoo Clock
// Ref: https://www.codewars.com/kata/656e4602ee72af0017e37e82
struct Time {
    let min: Int
    let hour: Int
    
    init(min: Int, hour: Int) {
        self.min = min
        self.hour = hour
    }
    
    init(_ inputTime: String) {
        let parts = inputTime.split(separator: ":")
        hour = Int(parts[0]) ?? 0
        min = Int(parts[1]) ?? 0
    }
    
    var countOfChimes: Int {
        guard min % 15 == 0 else { return 0 }
        return min == 0 ? hour : 1
    }
    
    var representation: String {
        String(format: "%02d:%02d", hour, min)
    }
    
    mutating func nextStep() {
        var newHour = hour
        var newMin = min
        newMin += min % 15 == 0 ? 15 : (15 - min % 15)
        if newMin == 60 {
            newHour += 1
            newMin = 0
        }
        if newHour == 13 {
            newHour = 1
        }
        self = Time(min: newMin, hour: newHour)
    }
}

func cuckooClock(_ inputTime: String, _ chimes: Int) -> String {
    var time = Time(inputTime)
    var remainChimes = chimes - time.countOfChimes
    while remainChimes > 0 {
        time.nextStep()
        remainChimes -= time.countOfChimes
    }
    return time.representation
}
