//
//  Kyu6_2.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 30.06.2024.
//

import Foundation

enum Kyu6_2 {
    // Task: Moves in squared strings (IV)
    // Ref: 56dbf59b0a10feb08c000227
    func diag2Sym(_ s: String) -> String {
        let tmpArr: [String] = s.split(separator: "\n").map { String($0.reversed()) }.reversed()
        let n = tmpArr.count
        var resultStrings = [String]()
        for i in 0..<n {
            var element = ""
            for chIndex in 0..<n {
                let str = tmpArr[chIndex]
                let index = str.index(str.startIndex, offsetBy: i)
                element += str[index...index]
            }
            resultStrings.append(element)
        }
        return resultStrings.joined(separator: "\n")
    }
    func rot90Counter(_ s: String) -> String {
        let tmpArr: [String] = s.split(separator: "\n").map { String($0.reversed()) }
        let n = tmpArr.count
        var resultStrings = [String]()
        for i in 0..<n {
            var element = ""
            for chIndex in 0..<n {
                let str = tmpArr[chIndex]
                let index = str.index(str.startIndex, offsetBy: i)
                element += str[index...index]
            }
            resultStrings.append(element)
        }
        return resultStrings.joined(separator: "\n")
    }

    func selfieDiag2Counterclock(_ s: String) -> String {
        let initial = s.split(separator: "\n")
        let digit = diag2Sym(s).split(separator: "\n")
        let rotation = rot90Counter(s).split(separator: "\n")
        let strings = initial.indices.map { "\(initial[$0])|\(digit[$0])|\(rotation[$0])" }
        return strings.joined(separator: "\n")
    }

    // replace the dots by your function parameter
    func oper(_ fcn: (String) -> String, _ s: String) -> String {
        fcn(s)
    } 
}
