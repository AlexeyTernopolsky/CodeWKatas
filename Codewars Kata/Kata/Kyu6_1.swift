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
    
    // Task: English beggars
    // Ref: 59590976838112bfea0000fa
    func beggars(_ values: [Int], _ n: Int) -> [Int] {
        guard n > 0 else { return [Int]() }
        var result = [Int](repeating: 0, count: n)
        for index in values.indices {
            result[index % n] += values[index]
        }
        return result
    }
    
    // Task: Moves in squared strings (II)
    // Ref: 56dbe7f113c2f63570000b86
    func rot(_ s: String) -> String {
        String(s.split(separator: "\n").map { $0.reversed() }.reversed().joined(separator: "\n"))
    }
    
    func selfieAndRot(_ s: String) -> String {
        let items = s.split(separator: "\n")
        let dots = String(repeating: ".", count: items.count)
        var newItems = items.map { String($0) + dots }
        for index in stride(from: items.count - 1, to: -1, by: -1) {
            newItems.append(String(newItems[index].reversed()))
        }
        return newItems.joined(separator: "\n")
    }
    
    // replace the dots by your function parameter
    func oper(_ function: (String) -> String, _ s: String) -> String {
        function(s)
    }
    
    // Task: Split Strings
    // Ref: 515de9ae9dcfc28eb6000001
    func solution(_ str: String) -> [String] {
        let updatedStr = str.count % 2 == 0 ? str : (str + "_")
        var result = [String]()
        var index = updatedStr.startIndex
        while index != updatedStr.endIndex {
            let nextIndex = updatedStr.index(after: index)
            result.append(String(updatedStr[index...nextIndex]))
            index = updatedStr.index(after: nextIndex)
        }
        return result
    }
    
    // Task: Allocating Hotel Rooms
    // Ref: 6638277786032a014d3e0072
    class Customer {
        let arrival: Int
        let departure: Int
        let index: Int
        var room: Int
        
        init(arrival: Int, departure: Int, index: Int) {
            self.arrival = arrival
            self.departure = departure
            self.index = index
            self.room = 0
        }
    }
    
    func allocateRooms(_ customers: [[Int]]) -> [Int] {
        var c = customers.enumerated().map {
            Customer(arrival: $0.element[0], departure: $0.element[1], index: $0.offset)
        }.sorted { $0.arrival < $1.arrival }
        c[0].room = 1
        var roomsDeparture = [c[0].departure]
        for index in 1..<c.count {
            let curCustomer = c[index]
            if let freeRoom = roomsDeparture.firstIndex { $0 < curCustomer.arrival  } {
                roomsDeparture[freeRoom] = curCustomer.departure
                curCustomer.room = freeRoom + 1
            } else {
                roomsDeparture.append(curCustomer.departure)
                curCustomer.room = roomsDeparture.count
            }
        }
        
        return c.sorted { $0.index < $1.index }.map { $0.room }
    }
    
    // Task: Dashatize it
    // Ref: 58223370aef9fc03fd000071
    func dashatize(_ number: Int) -> String {
        guard number != 0 else { return "0" }
        var remainder = abs(number)
        var items = [String]()
        while remainder > 0 {
            let digit = remainder % 10
            if digit % 2 == 1 {
                if !items.isEmpty && items[0] != "-" {
                    items.insert("-", at: 0)
                }
                items.insert(String(digit), at: 0)
                items.insert("-", at: 0)
            } else {
                items.insert(String(digit), at: 0)
            }
            remainder /= 10
        }
        
        if items.first == "-" {
            items.remove(at: 0)
        }
        
        return items.joined(separator: "")
    }
    
    // Task: Banker's Plan
    // Ref: 56445c4755d0e45b8c00010a
    func fortune(_ f0: Int, _ p: Double, _ c0: Int, _ n: Int, _ i: Double) -> Bool {
        var curF = f0
        var curC = c0
        var curYear = 1
        
        while curYear < n && curF >= 0 {
            curF += Int(Double(curF) * p / 100.0) - curC
            curC += Int(Double(curC) * i / 100.0)
            curYear += 1
        }
        
        return curF >= 0
    }
    
    // Task: Give me a Diamond
    // Ref: 5503013e34137eeeaa001648
    func diamond(_ size: Int) -> String? {
        guard size > 0 && size % 2 == 1 else { return nil }
        var strings = [String]()
        for i in stride(from: 1, through: size, by: 2) {
            let emptyCharacters = (size - i) / 2
            strings.append(String(repeating: " ", count: emptyCharacters) + String(repeating: "*", count: i) + "\n")
        }
        for i in stride(from: size-2, through: 1, by: -2) {
            let emptyCharacters = (size - i) / 2
            strings.append(String(repeating: " ", count: emptyCharacters) + String(repeating: "*", count: i) + "\n")
        }
        return strings.joined()
    }
    
    // Task: Hidden "Cubic" numbers
    // Ref: 55031bba8cba40ada90011c4
    func isCubicNumber(_ numStr: String) -> Bool {
        Int(numStr) == numStr.reduce(0) { $0 + Int(pow(Double($1.wholeNumberValue ?? 0), 3.0))  }
    }
    
    func isSumOfCubes(_ s: String) -> String {
        var tmpStr = ""
        var groups = [String]()
        s.forEach {
            if $0.isNumber {
                tmpStr += String($0)
                if tmpStr.count == 3 {
                    groups.append(tmpStr)
                    tmpStr = ""
                }
            } else if !tmpStr.isEmpty {
                groups.append(tmpStr)
                tmpStr = ""
            }
        }
        if !tmpStr.isEmpty {
            groups.append(tmpStr)
        }
        
        groups = groups.filter { isCubicNumber($0) }
        if groups.isEmpty {
            return "Unlucky"
        } else {
            let numbers = groups.map { Int($0) ?? 0 }
            let sum = numbers.reduce(0, +)
            return numbers.map { String($0) }.joined(separator: " ") + " \(sum) Lucky"
        }
    }
    
    // Task: Prize Draw
    // Ref: 5616868c81a0f281e500005c
    func calculateWNumber(_ name: String, weight: Int) -> Int {
        let name = name.lowercased()
        let aChValue = "a".first?.unicodeScalars.first?.value ?? 0
        let sum = name.compactMap {
            if let nameChValue = $0.unicodeScalars.first?.value {
                return Int(nameChValue - aChValue + 1)
            } else { return nil }
        }.reduce(0, +) + name.count
        return sum*weight
    }

    func rank(_ st: String, _ we: [Int], _ n: Int) -> String {
        guard !st.isEmpty else { return "No participants" }
        let names = st.split(separator: ",").map { String($0) }
        guard names.count >= n else { return "Not enough participants" }
        var ranks = names.indices.map { (name: names[$0], wNumber: calculateWNumber(names[$0], weight: we[$0])) }
        ranks.sort {
            if $0.wNumber != $1.wNumber {
                return $0.wNumber > $1.wNumber
            } else {
                return $0.name < $1.name
            }
        }
        return ranks[n - 1].name
    }
    
    // Task: Persistent Bugger.
    // Ref: 55bf01e5a717a0d57e0000ec
    func persistence(for num: Int) -> Int {
      guard num >= 10 else { return 0 }
      let multiplication = String(num).compactMap { $0.wholeNumberValue }.reduce(1, *)
      return 1 + persistence(for: multiplication)
    }
    
    // Task: Decode the Morse code
    // Ref: 54b724efac3d5402db00065e
    func decodeMorse(_ morseCode: String) -> String {
        let MorseCode = ["a" : "_" ]
        return morseCode.trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "   ")
            .map { $0.split(separator: " ").compactMap { MorseCode[String($0)] }.joined(separator: "") }
            .joined(separator: " ")
    }
    
    // Task: The PaperFold sequence
    // Ref: 5d26721d48430e0016914faa
    func areaOfPolygonInsideCircle(_ circleRadius: Double, _ numberOfSides: Int) -> Double {
      let area = sin(2.0 * Double.pi / Double(numberOfSides)) * circleRadius * circleRadius * Double(numberOfSides) / 2.0
      return round(area * 1000.0) / 1000.0
    }
    
    // Task: Duplicate Encoder
    // Ref: 54b42f9314d9229fd6000d9c
    func duplicateEncode(_ word: String) -> String {
        let input = word.lowercased()
        var chCount = [Character: Int]()
        input.forEach {
            chCount[$0] = chCount[$0, default: 0] + 1
        }
        return input.map { chCount[$0] == 1 ? "(" : ")" }.joined(separator: "")
    }
}
