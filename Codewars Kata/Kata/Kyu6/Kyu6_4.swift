//
//  Kyu6_4.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 29.08.2024.
//

import Foundation

enum Kyu6_4 {
    case one
    // Task: Esolang Interpreters #1 - Introduction to Esolangs and My First Interpreter (MiniStringFuck)
    // Ref: https://www.codewars.com/kata/586dd26a69b6fd46dd0000c0
    func interpreter(_ prog: String) -> String {
        prog.reduce((cell: 0, output: "")) { op, ch in
            switch ch {
            case "+": return ((op.cell + 1) % 256, op.output)
            case ".": return (op.cell, op.output + String(UnicodeScalar(op.cell)!))
            default: return op
            }
        }.output
    }
}
