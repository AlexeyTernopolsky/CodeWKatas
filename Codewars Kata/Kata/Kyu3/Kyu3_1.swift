//
//  Kyu3_1.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 29.08.2024.
//

import Foundation

enum Kyu3_1 {
    // Task: Esolang Interpreters #4 - Boolfuck Interpreter
    // Ref: https://www.codewars.com/kata/5861487fdb20cff3ab000030
    func buildGotoMap(code: String) -> [String.Index : String.Index] {
        var stack = [String.Index]()
        // Fill goto dictionary
        var gotoDictionary = [String.Index : String.Index]()
        code.indices.forEach {
            switch code[$0] {
            case "[": stack.append($0)
            case "]": if let prev = stack.popLast() {
                gotoDictionary[prev] = $0
                gotoDictionary[$0] = prev
            }
            default: break
            }
        }
        return gotoDictionary
    }

    class BoolFuckInput {
        private let inputStr: String
        private var curIndex: String.Index
        private var remain: Int
        private var curBitIndex = 0
        
        init(_ input: String) {
            inputStr = input
            curIndex = input.startIndex
            if curIndex == input.endIndex {
                remain = 0
            } else {
                remain = Int(input[curIndex].unicodeScalars.first?.value ?? 0)
            }
        }
        
        func consume() -> Bool {
            let result = remain % 2 == 1
            curBitIndex += 1
            if curBitIndex == 8 {
                curBitIndex = 0
                curIndex = curIndex == inputStr.endIndex ? inputStr.endIndex : inputStr.index(after: curIndex)
                remain = curIndex == inputStr.endIndex ? 0 : Int(inputStr[curIndex].unicodeScalars.first?.value ?? 0)
            } else {
                remain /= 2
            }
            return result
        }
    }

    class BoolFuckOutput {
        private var output = ""
        private var curValue = 0
        private var curBitIndex = 0
        
        func pushBit(_ bit: Bool) {
            curValue |= ((bit ? 1 : 0) << curBitIndex)
            curBitIndex += 1
            if curBitIndex == 8 {
                curBitIndex = 0
                output += String(UnicodeScalar(curValue)!)
                curValue = 0
            }
        }
        
        func finalOutput() -> String {
            if curBitIndex > 0 {
                output += String(UnicodeScalar(curValue)!)
            }
            return output
        }
    }

    func boolfuck(_ code: String, _ input: String = "") -> String {
        let bfInput = BoolFuckInput(input)
        let bfOutput = BoolFuckOutput()
        var memory = [0 : false]
        var memoryIndex = 0
        let gotoMap = buildGotoMap(code: code)
        var codeIndex = code.startIndex
        while codeIndex < code.endIndex {
            switch code[codeIndex] {
            case "+": memory[memoryIndex] = memory[memoryIndex, default: false] ? false : true
            case ",": memory[memoryIndex] = bfInput.consume()
            case ";": bfOutput.pushBit(memory[memoryIndex, default: false])
            case "<": memoryIndex -= 1
            case ">": memoryIndex += 1
            case "[": if !memory[memoryIndex, default: false] { codeIndex = gotoMap[codeIndex]! }
            case "]": if memory[memoryIndex, default: false] { codeIndex = gotoMap[codeIndex]! }
            default: break
            }
            codeIndex = code.index(after: codeIndex)
        }
        return bfOutput.finalOutput()
    }
}
