//
//  ProjectileMotion.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 29.08.2024.
//

import Foundation

// Task: Projectile Motion
// Ref: https://www.codewars.com/kata/5af96cea3e9715ec670001dd
class Projectile{
    private let hV: Double
    private let vV: Double
    private let initialH: Double
    
    init(h: Int, v0: Int, a: Int) {
        initialH = Double(h)
        hV = Double(v0) * cos(Double(a) * Double.pi / 180.0)
        vV = Double(v0) * sin(Double(a) * Double.pi / 180.0)
    }
    
    private func formatDouble(_ number: Double) -> Double {
        round(number * 1000.0) / 1000.0
    }
    
    func heightEq() -> String {
        "h(t) = -16.0t^2 + \(formatDouble(vV))t" + (initialH == 0.0 ? "" : " + \(initialH)")
    }
    
    func horizEq() -> String {
        "x(t) = \(formatDouble(hV))t"
    }
    
    func height(time: Double) -> Double {
        formatDouble(-16.0 * time * time + vV * time + initialH)
    }
    
    func horiz(time: Double) -> Double {
        formatDouble(hV * time)
    }
    
    func landing() -> [Double] {
        let t0 = (vV + sqrt(vV * vV + 64 * initialH)) / 32
        return [formatDouble(hV * t0), 0.0, formatDouble(t0)]
    }
}
