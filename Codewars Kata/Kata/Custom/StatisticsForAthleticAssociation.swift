//
//  StatisticsForAthleticAssociation.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 29.08.2024.
//

import Foundation

// Task: Statistics for an Athletic Association
// Ref: https://www.codewars.com/kata/55b3425df71c1201a800009c
struct TimeValue {
    let seconds: Int
    
    static func fromStr(_ str: String) -> TimeValue {
        let ags = str.split(separator: "|").compactMap { Int($0) }
        return TimeValue(seconds: (ags[0] * 60 + ags[1]) * 60 + ags[2] )
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: TimeValue) {
        let h = value.seconds / 3600
        let m = (value.seconds % 3600) / 60
        let s = value.seconds % 60
        let str =  String(format: "%02d|%02d|%02d", h, m, s)
        appendInterpolation(str)
    }
}

func stat(_ strg: String) -> String {
    var runners = strg.split(separator: ",").map { TimeValue.fromStr(String($0)) }
    runners = runners.sorted(by: { one, two in one.seconds < two.seconds})
    let range = TimeValue(seconds: runners.last!.seconds - runners.first!.seconds)
    let average = TimeValue(seconds: runners.reduce(0) { $0 + $1.seconds } / runners.count)
    let halfSize = runners.count / 2
    let median = runners.count % 2 == 0 ? TimeValue(seconds: (runners[halfSize].seconds + runners[halfSize - 1].seconds) / 2) : runners[halfSize]
    return "Range: \(range) Average: \(average) Median: \(median)"
}
