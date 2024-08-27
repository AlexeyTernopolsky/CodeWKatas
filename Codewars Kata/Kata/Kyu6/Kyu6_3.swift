//
//  Kyu6_3.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 29.08.2024.
//

import Foundation

enum Kyu6_3 {
    case one
    // Task: Moves in squared strings (III)
    // Ref: https://www.codewars.com/kata/56dbeec613c2f63be4000be6
    func diag1Sym(_ parts: [String]) -> [String] {
        var result = [String]()
        for x in parts.indices {
            var element = String()
            for str in parts {
                let index = str.index(str.startIndex, offsetBy: x)
                element.append(str[index])
            }
            result.append(element)
        }
        return result
    }
    
    func diag1Sym(_ s: String) -> String {
        diag1Sym(s.split(separator: "\n").map { String($0) }).joined(separator: "\n")
    }
    
    func rot90Clock(s: String) -> String {
        diag1Sym(s.split(separator: "\n").map { String($0) }).map { String($0.reversed()) }.joined(separator: "\n")
    }
    
    func selfieAndDiag1(_ s: String) -> String {
        let parts = s.split(separator: "\n").map { String($0) }
        let diagParts = diag1Sym(parts)
        return parts.indices.map { "\(parts[$0])|\(diagParts[$0])" }.joined(separator: "\n")
    }
    // replace the dots with function parameter
    func oper(_ fun: (String)->String, _ s: String) -> String {
        fun(s)
    }
    
    // Task: Linked Lists - Length & Count
    // Ref: https://www.codewars.com/kata/55beec7dd347078289000021
    class Node {
        var data: Int
        var next: Node?
        init(_ data: Int) {
            self.data = data
        }
    }
    
    func count(in head: Node?, of: (Node)->Bool) -> Int {
        var count = 0
        var current = head
        while current != nil {
            if let current, of(current) {
                count += 1
            }
            current = current?.next
        }
        return count
    }
    
    func length(_ head: Node?) -> Int {
        count(in: head) {_ in true }
    }
    
    func count(_ head: Node?, _ data: Int) -> Int {
        count(in: head) { $0.data == data }
    }
    
    // Task: Sorting on planet Twisted-3-7
    // Ref: https://www.codewars.com/kata/58068479c27998b11900056e
    func sortTwisted37(_ arr: [Int]) -> [Int] {
        func twist(_ number: Int) -> Int {
            var str = String(number)
            str.replace("7", with: "*")
            str.replace("3", with: "7")
            str.replace("*", with: "3")
            return Int(str) ?? 0
        }
        
        return arr.sorted { a, b in
            return twist(a) < twist(b)
        }
    }
    
    // Task: Calculate String Rotation
    // Ref: https://www.codewars.com/kata/5596f6e9529e9ab6fb000014
    func shiftedDiff(_ s1: String, _ s2: String) -> Int? {
        func shiftTo(_ offset: Int) -> String {
            return String(s1.dropFirst(s1.count - offset) + s1.dropLast(offset))
        }
        for i in 0..<s1.count {
            if s2 == shiftTo(i) {
                return i
            }
        }
        return nil
    }
    
    // Task: New Cashier Does Not Know About Space or Shift
    // Ref: https://www.codewars.com/kata/5d23d89906f92a00267bb83d
    func getOrder(_ input: String) -> String {
        let menu = ["Burger", "Fries", "Chicken", "Pizza", "Sandwich", "Onionrings", "Milkshake", "Coke"]
        var remain = input
        var output = [String]()
        for item in menu {
            while let range = remain.range(of: item.lowercased()) {
                output.append(item)
                remain.removeSubrange(range)
            }
        }
        return output.joined(separator: " ")
    }
    
    // Task: Mexican Wave
    // Ref: https://www.codewars.com/kata/58f5c63f1e26ecda7e000029
    func wave(_ y: String) -> [String] {
        y.indices.reduce([String]()) { ar, index in
            if y[index] == " " {
                return ar
            } else {
                let item = y[y.startIndex..<index] + y[index].uppercased() + y[y.index(after: index)..<y.endIndex]
                return ar + [String(item)]
            }
        }
    }
    
    // Task: Write Number in Expanded Form
    // Ref: https://www.codewars.com/kata/5842df8ccbd22792a4000245
    func expandedForm(_ num: Int64) -> String {
        var remain = num
        var array = [Int64]()
        var multiple: Int64 = 1
        while remain != 0 {
            let next = (remain % 10) * multiple
            if next > 0 {
                array.insert(next, at: 0)
            }
            remain /= 10
            multiple *= 10
        }
        return array.map { String($0) }.joined(separator: " + ")
    }
    
    // Task: How Much?
    // Ref: https://www.codewars.com/kata/55b4d87a3766d9873a0000d4
    func howMuch(_ m: Int, _ n: Int) -> [(String, String, String)] {
        print("m = \(m), n = \(n)")
        var result = [(String, String, String)]()
        let min = min(m, n)
        let max = max(m, n)
        let start = (min - 1) / 9 * 9
        for number in stride(from: start, to: max, by: 9) {
            if (number - 1) % 7 == 0 && number >= min - 1 {
                result.append(("M: \(number + 1)", "B: \(number / 7)" , "C: \(number / 9)"))
            }
        }
        return result
    }
    
    // Task: Find The Parity Outlier
    // Ref: https://www.codewars.com/kata/5526fc09a1bbd946250002dc
    func findOutlier(_ array: [Int]) -> Int {
        let (a, b, c) = (array[0] % 2 == 0, array[1] % 2 == 0, array[2] % 2 == 0)
        let remain = (a && b) || (a && c ) || (b && c)  ? 1 : 0
        return array.first { abs($0) % 2 == remain } ?? -1
    }
    
    // Task: Playing with digits
    // Ref: https://www.codewars.com/kata/5552101f47fc5178b1000050
    func digPow(for number: Int, using power: Int) -> Int {
        var add = 0
        let sum = String(number).compactMap { $0.wholeNumberValue }.reduce(UInt64(0)) { sum, item in
            let newValue = sum + UInt64(pow(Double(item), Double(power + add)))
            add += 1
            return newValue
        }
        let lNumber = UInt64(number)
        return sum % lNumber == 0 ? Int(sum / lNumber) : -1
    }
    
    // Task: Stop gninnipS My sdroW!
    // Ref: https://www.codewars.com/kata/5264d2b162488dc400000001
    func spinWords(in sentence: String) -> String {
        sentence.split(separator: " ").map { $0.count >= 5 ? String($0.reversed()) : String($0) }.joined(separator: " ")
    }
    
    // Task: Reducing by steps
    // Ref: https://www.codewars.com/kata/56efab15740d301ab40002ee
    func som(_ x: Int, _ y: Int) -> Int {
        x + y
    }
    func maxi(_ x: Int, _ y: Int) -> Int {
        max(x, y)
    }
    func mini(_ x: Int, _ y: Int) -> Int {
        min(x, y)
    }
    func gcdi(_ x: Int, _ y: Int) -> Int {
        var (a, b) = (max(x, y), min(x, y))
        while b != 0 {
            (a, b) = (b, a % b)
        }
        return abs(a)
    }
    func lcmu(_ a: Int, _ b: Int) -> Int {
        abs(a * b / gcdi(a, b))
    }
    
    // replace the dots with a declaration of function
    func operArray(_ op: (Int, Int) -> Int, _ a: [Int], _ iniVal: Int) -> [Int] {
        var firstArg = iniVal
        return a.map {
            firstArg = op(firstArg, $0)
            return firstArg
        }
    }
    
    // Task: Tank Truck
    // Ref: https://www.codewars.com/kata/55f3da49e83ca1ddae0000ad
    func tankVol(_ h: Int, _ d: Int, _ vt: Int) -> Int {
        let radius = Double(d) / 2
        // R^2 is used in circle square and in the segment, so we can avoid it
        let fullCircleSquare = Double.pi
        let angle = 2 * acos((radius - Double(h)) / radius)
        let segmentSquare = (angle - sin(angle)) / 2
        return Int(Double(vt) * segmentSquare / fullCircleSquare)
    }
    
    // Task: Does my number look big in this?
    // Ref: https://www.codewars.com/kata/5287e858c6b5a9678200083c
    func isNarcissistic(_ n: Int64) -> Bool {
        func manualPow(_ base: Int64, _ power: Int) -> Int64 { (1...power).reduce(1) { mult, _ in mult*base } }
        let nStr = String(n)
        let sum = nStr.compactMap { $0.wholeNumberValue }.reduce(0) { sum, item in
            sum + manualPow(Int64(item), nStr.count)
        }
        return sum == n;
    }
    
    // Task: Simpson's Rule - Approximate Integration
    // Ref: https://www.codewars.com/kata/565abd876ed46506d600000d
    func f(_ x: Double) -> Double { 3.0 / 2.0 * pow(sin(x), 3) }
    func simpson(_ n: Int) -> Double {
        let a = 0.0
        let b = Double.pi
        let h = (b - a) / Double(n)
        let firstSum = (1...n/2).map { f(a + (2.0 * Double($0) - 1.0) * h) }.reduce(0, +)
        let secondSum = (1...(n/2 - 1)).map { f(a + 2 * Double($0) * h) }.reduce(0, +)
        let funcSum = f(a) + f(b) + 4.0 * firstSum + 2.0 * secondSum
        return (b - a) / (3 * Double(n)) * funcSum
    }
    
    // Task: Fixed xor
    // Ref: https://www.codewars.com/kata/580f1220df91273ee90001e7
    func fixedXor(_ a: String, _ b: String) -> String {
        let size = min(a.count, b.count)
        var index1 = a.startIndex
        var index2 = b.startIndex
        let elements = (0..<size).map { _ in
            let one = a[index1...index1]
            let two = b[index2...index2]
            let xorResult = Int(one, radix: 16)! ^ Int(two, radix: 16)!
            index1 = a.index(after: index1)
            index2 = b.index(after: index2)
            return String(format: "%01x", xorResult)
        }
        return elements.joined(separator: "")
    }
    
    // Task: Generic numeric template formatter
    // Ref: https://www.codewars.com/kata/59901fb5917839fe41000029
    func numericFormatter(_ template: String, _ numbers: String = "1234567890") -> String {
        var nIndex = numbers.startIndex
        return template.map {
            var result = numbers[nIndex]
            if $0.isLetter {
                nIndex = numbers.index(after: nIndex)
                if nIndex == numbers.endIndex {
                    nIndex = numbers.startIndex
                }
            } else {
                result = $0
            }
            return String(result)
        }.joined(separator: "")
    }
    
    // Task: Disease Spread
    // Ref: https://www.codewars.com/kata/566543703c72200f0b0000c9
    func epidemic(_ tm: Int, _ n: Int, _ s0: Int, _ i0: Int, _ b: Double, _ a: Double) -> Int {
        let dt = Double(tm) / Double(n)
        var (S, I, R) = (Double(s0), Double(i0), 0.0)
        var maxInfected = I
        for _ in 1...n {
            (S, I, R) = (S - dt * b * S * I, I + dt * (b * S * I - a * I), R + dt * I * a)
            maxInfected = max(maxInfected, I)
        }
        return Int(maxInfected)
    }
    
    // Task: Salesman's Travel
    // Ref: https://www.codewars.com/kata/56af1a20509ce5b9b000001e
    func travel(_ r: String, zipcode: String) -> String {
        let zipCodeReg = try! Regex("[A-Z]{2} \\d{5}")
        guard zipcode.wholeMatch(of: zipCodeReg) != nil else { return "\(zipcode):/"}
        let reg = try! Regex("(?<home>\\d+) (?<street>(\\w|\\s|\\.)+) \(zipcode)")
        let results = r.matches(of: reg)
        let homes = results.compactMap { $0["home"]?.value as? Substring }
        let streets = results.compactMap { $0["street"]?.value as? Substring }
        return "\(zipcode):\(streets.joined(separator: ","))/\(homes.joined(separator: ","))"
    }
    
    // Task: Integers: Recreation Two
    // Ref: https://www.codewars.com/kata/55e86e212fce2aae75000060
    func prod2sum(_ a: Int64, _ b: Int64, _ c: Int64, _ d: Int64) -> [(Int64, Int64)] {
        var notUnique = [(abs(b * c - a * d), abs(a * c + b * d)), (abs(a * c - b * d), abs(b * c + a * d))]
        notUnique = notUnique.map { (min($0.0, $0.1), max($0.0, $0.1)) }.sorted { $0.0 <= $1.0 }
        var result = [(Int64, Int64)]()
        notUnique.forEach { nUElement in if !result.contains(where: { element in element == nUElement }) { result.append(nUElement) }}
        return result
    }
    
    // Task: Playing on a chessboard
    // Ref: https://www.codewars.com/kata/55ab4f980f2d576c070000f4
    func game (_ n: UInt64) -> String {
        n * n % 2 == 0 ? "[\(n * n / 2)]" : "[\(n * n), 2]"
    }
    
    // Task: Ball Upwards
    // Ref: https://www.codewars.com/kata/566be96bb3174e155300001b
    func maxBall(_ v0: Int) -> Int {
        let v = Double(v0) * 1000.0 / 3600.0
        let g = 9.81
        var prevHeight = -1.0
        var curHeight = 0.0
        var timeIndex = 0
        while prevHeight < curHeight {
            prevHeight = curHeight
            timeIndex += 1
            let time = Double(timeIndex) / 10.0
            curHeight = v * time - 0.5 * g * time * time
        }
        return timeIndex - 1
    }
    
    // Task: Backwards Read Primes
    // Ref: https://www.codewars.com/kata/5539fecef69c483c5a000015
    func backwardsPrime(_ start: Int, _ stop: Int) -> [Int] {
        func isPrime(_ number: Int) -> Bool {
            guard number > 3 else { return number == 2 || number == 3 }
            for i in 2...Int(sqrt(Double(number))) {
                if number % i == 0 { return false }
            }
            return true
        }
        func isNotSameBackward(_ number: Int) -> Bool {
            String(number) != String(String(number).reversed())
        }
        return (start...stop).filter { isPrime($0) && isNotSameBackward($0) && isPrime(Int(String(String($0).reversed())) ?? 0) }
    }
    
    // Task: Steps in Primes
    // Ref: https://www.codewars.com/kata/5613d06cee1e7da6d5000055
    func step(_ g: Int, _ m: Int, _ n: Int) -> (Int, Int)? {
        guard g <= n - m else { return nil }
        return (m...n-g).first(where: { $0.isPrime && ($0 + g).isPrime }).map { ($0, $0 + g) }
    }
    
    // Task: Esolang: Tick
    // Ref: https://www.codewars.com/kata/587edac2bdf76ea23500011a
    func interpreter(_ prog: String) -> String {
        var memory = [0]
        var memoryIndex = 0
        var output = ""
        prog.forEach { ch in
            switch ch {
            case ">":
                memoryIndex += 1
                if memoryIndex == memory.count {
                    memory.append(0)
                }
            case "<":
                memoryIndex -= 1
                if (memoryIndex == -1) {
                    memory.insert(0, at: 0)
                    memoryIndex = 0
                }
            case "+": memory[memoryIndex] = (memory[memoryIndex] + 1) % 256
            case "*": output += String(UnicodeScalar(memory[memoryIndex])!)
            default: break
            }
            
        }
        return output
    }
}

extension Int {
    var isPrime: Bool {
        self < 4 ? (self == 2 || self == 3) : (2...Int(sqrt(Double(self)))).allSatisfy { self % $0 != 0 }
    }
}
