//
//  Kyu6_1.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 26.02.2023.
//

import Foundation

// Some functions can have same names, need to wrap in different enums(as namespace)
enum Kyu6_1 {
    // Task: Two Sum
    // Ref: 52c31f8e6605bcc646000082
    class Solution {
        static func twosum(numbers: [Double], target: Double) -> [Int] {
            for i in numbers.indices {
                let one = numbers[i]
                var j = i + 1
                while j < numbers.count {
                    let two = numbers[j]
                    if one + two == target {
                        return [i, j]
                    }
                    j += 1
                }
            }
            
            return [-1, -1]
        }
    }
    
    // Task: Counting Duplicates
    // Ref: 54bf1c2cd5b56cc47f0007a1
    func countDuplicates(_ s:String) -> Int {
        var dict = [Character : Int]()
        var result = 0
        
        for ch in s.lowercased() {
            if let count = dict[ch] {
                if count == 1 {
                    result += 1
                    dict[ch] = 2
                }
            } else {
                dict[ch] = 1
            }
        }
        
        return result
    }
    
    // Task: Rectangle into Squares
    // Ref: 55466989aeecab5aac00003e
    func sqInRect(_ lng: Int, _ wdth: Int) -> [Int]? {
        guard lng != wdth else { return nil }
        
        var result = [Int]()
        var tLng = lng
        var tWidth = wdth
        
        while (tLng != 0) && (tWidth != 0) {
            let minSide = min(tLng, tWidth)
            let maxSide = max(tLng, tWidth)
            let squareCount = maxSide / minSide
            for _ in 1...squareCount {
                result.append(minSide)
            }
            
            tLng = minSide
            tWidth = maxSide - minSide * squareCount
        }
        
        return result
    }
    
    // Task: Tribonacci Sequence
    // Ref: 556deca17c58da83c00002db
    func tribonacci(_ signature: [Int], _ n: Int) -> [Int] {
        var result = [Int]()
        guard signature.count == 3 else { return result }
        
        for i in 0..<n {
            let nextValue = i < signature.count ? signature[i] :
            (result[i - 3] + result[i-2] + result[i - 1])
            result.append(nextValue)
        }
        
        return result
    }
    
    // Task: Valid Braces
    // Ref: 5277c8a221e209d3f6000b56
    func validBraces(_ string:String) -> Bool {
        func symbolType(_ char: Character) -> (type: Int, open:Bool) {
            switch char {
            case "(": return (0, true)
            case ")": return (0, false)
            case "{": return (1, true)
            case "}": return (1, false)
            case "[": return (2, true)
            case "]": return (2, false)
            default: return (3, false)
            }
        }
        
        var curLevels = [0, 0, 0]
        var charStacks = [[[Int]](), [[Int]](), [[Int]]()]
        
        for ch in string {
            let charInfo = symbolType(ch)
            guard charInfo.type < 3 else { return false }
            
            if charInfo.open {
                charStacks[charInfo.type].append(curLevels)
                curLevels[charInfo.type] += 1
            } else {
                guard !charStacks[charInfo.type].isEmpty else {return false}
                
                curLevels[charInfo.type] -= 1
                let prevSet = charStacks[charInfo.type].removeLast()
                if prevSet != curLevels {
                    return false
                }
            }
        }
        
        return curLevels == [0, 0, 0]
    }
    
    // Task: Find the odd int
    // Ref: 54da5a58ea159efa38000836
    func findIt(_ seq: [Int]) -> Int {
        seq.reduce(0) { result, item in
            result ^ item
        }
    }
    
    // Task: Sum of Digits / Digital Root
    // Ref: 541c8630095125aba6000c00
    func digitalRoot(of number: Int) -> Int {
      if number < 10 {
        return number
      } else {
        var i = number
        var sum = 0
        while i > 0 {
          sum += i % 10
          i = i / 10
        }
        return digitalRoot(of: sum)
      }
    }
    
    // Task: Fold an array
    // Ref: 57ea70aa5500adfe8a000110
    func foldArray(_ arr: [Int], times: Int) -> [Int] {
        guard arr.count > 1 && times > 0 else { return arr }
        
        var oneSum = [Int]()
        let lastPos = arr.count - 1
        
        for i in 0..<arr.count / 2 {
            oneSum.append(arr[i] + arr[lastPos - i])
        }
        
        if arr.count % 2 == 1 {
            oneSum.append(arr[arr.count / 2])
        }
        
        return foldArray(oneSum, times: times - 1)
    }
    
    // Task: Basics 08: Find next higher number with same Bits (1's)
    // Ref: 56bdd0aec5dc03d7780010a5
    func sumOfBits(_ n: Int) -> Int {
        var result = 0
        var nD = n
        while nD > 0 {
            result += nD % 2
            nD = nD >> 1
        }
        
        return result
    }


    func nextHigher(_ n: Int) -> Int {
        let originalSum = sumOfBits(n)
        var result = n + 1
        while originalSum != sumOfBits(result) {
            result += 1
        }
        return result
    }
    
    // Task: Playing with passphrases
    // Ref: 559536379512a64472000053
    func playPass(_ s: String, _ n: Int) -> String {
        var result = ""
        let zeroValue = Int("0".unicodeScalars.first?.value ?? 0)
        let aValue = Int("A".unicodeScalars.first?.value ?? 0)
        let zValue = Int("Z".unicodeScalars.first?.value ?? 0)
        let modulo = zValue - aValue + 1
        var index = 0
        
        for char in s.uppercased() {
            if let number = char.wholeNumberValue {
                result += String(UnicodeScalar(zeroValue + 9 - number)!)
            } else if char.isLetter {
                var charValue = Int(char.unicodeScalars.first?.value ?? 0)
                charValue = (charValue - aValue + n) % modulo + aValue
                let add = String(UnicodeScalar(charValue)!)
                result += index % 2 == 1 ? add.lowercased() : add
            } else {
                result += String(char)
            }
            index += 1
        }
        
        return String(result.reversed())
    }
    
    // Task: Two Sets of Equal Sum
    // Ref: 647518391e258e80eedf6e06
    func createTwoSetsOfEqualSum(_ n: Int) -> [[Int]] {
        let sum = (1 + n) * n / 2
        guard sum % 2 == 0 else { return [] }
        var targetSum = sum / 2
        var second = [Int]()
        var lastCandidate = n
        while lastCandidate <= targetSum {
            second.append(lastCandidate)
            targetSum -= lastCandidate
            lastCandidate -= 1
        }
        
        
        if targetSum != 0 {
            second.append(targetSum)
        }
        
        var first = [Int]()
        for i in 1...lastCandidate {
            if i != targetSum {
                first.append(i)
            }
        }
        
        return [ first, second ]
    }
}



