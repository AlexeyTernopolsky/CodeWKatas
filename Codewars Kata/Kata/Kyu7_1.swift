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
    
    // Task: Resistor Color Codes
    // Ref: https://www.codewars.com/kata/57cf3dad05c186ba22000348
    func decodeResistorColors(_ bands: String) -> String {
        func decodeWord(_ word: String.SubSequence) -> Double {
            switch word {
            case "black": return 0
            case "brown": return 1
            case "red": return 2
            case "orange": return 3
            case "yellow": return 4
            case "green": return 5
            case "blue": return 6
            case "violet": return 7
            case "gray": return 8
            case "white": return 9
            default:
                fatalError("Unknown word")
            }
        }
        
        let words = bands.split(separator: " ")
        var tolerance = 20
        if words.count > 3 {
            switch words[3] {
            case "gold": tolerance = 5
            case "silver": tolerance = 10
            default:
                fatalError("Unknown word")
            }
        }
        
        var resistance = decodeWord(words[0]) * 10 + decodeWord(words[1])
        var power = pow(10, decodeWord(words[2]))
        resistance *= power
        var result = ""
        var resStr = ""
        if resistance < 1000.0 {
            resStr = String(format: "%g", resistance)
        } else if resistance < 1000000.0 {
            resStr = String(format: "%gk", resistance/1000.0)
        } else {
            resStr = String(format: "%gM", resistance/1000000.0)
        }
        
        result = "\(resStr) ohms, \(tolerance)%"
            
        return result
    }
}
