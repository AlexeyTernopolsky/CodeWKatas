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
    
    // Task: Roman Numerals Encoder
    // Ref: 51b62bf6a9c58071c600001b
    func solution(_ number:Int) -> String {
        let rimNumbers = [ 1000: "M", 900: "CM", 500: "D", 400: "CD", 100: "C", 90: "XC", 50: "L", 40: "XL", 10: "X", 9: "IX", 5: "V", 4: "IV", 1: "I"]
        var remain = number
        var result = ""
        for i in rimNumbers.keys.sorted().reversed() {
            while remain >= i {
                remain -= i
                result += rimNumbers[i] ?? ""
            }
        }
        return result
    }
    
    // Task: Experimenting with a sequence of complex numbers
    // Ref: 5b06c990908b7eea73000069
    struct Complex {
        let x, y: Double
        var norm: Double {
            hypot(x, y)
        }
        
        static func * (one: Complex, two: Complex) -> Complex {
            Complex(x: one.x*two.x - one.y*two.y, y: one.x * two.y + one.y * two.x)
        }
    }
    
    func f(_ x: Double, _ y: Double, _ eps: Double) -> Int {
        let z = Complex(x: x, y: y)
        if z.norm < 1 {
            var n = 1
            var difference = z * z
            while (difference.norm > eps) {
                n += 1
                difference = difference * z
            }
            return n
        }
        return -1
    }
    
    // Task: Parabolic Arc Length
    // Ref: 562e274ceca15ca6e70000d3
    func lenCurve(_ n: Int) -> Double {
        let xDif = 1.0 / Double(n)
        var prevY = 0.0
        var sumLen = 0.0
        for i in 1...n {
            let curX = xDif * Double(i)
            let curY = curX * curX
            sumLen += hypot(xDif, abs(curY - prevY))
            prevY = curY
        }
        return sumLen
    }
    
    // Task: Follow that Spy
    // Ref: 5899a4b1a6648906fe000113
    func findRoutes(routes: [[String]]) -> String? {
        var beginDic = [String: [String]](), endDic = [String: [String]]()
        for route in routes {
            beginDic[route[0]] = route
            endDic[route[1]] = route
        }
        var startPoint = routes[0][0]
        var endPoint = routes[0][1]
        var result = "\(startPoint), \(endPoint)"
        while endDic[startPoint] != nil {
            startPoint = endDic[startPoint]![0]
            result = "\(startPoint), \(result)"
        }
        while beginDic[endPoint] != nil {
            endPoint = beginDic[endPoint]![1]
            result = "\(result), \(endPoint)"
        }
        return result
    }
    
    // Task: Pyramid Array
    // Ref: 515f51d438015969f7000013
    func pyramid(_ n: Int) -> [[Int]] {
        guard n > 0 else { return [] }
        return (1...n).map { Array<Int>(repeating: 1, count: $0) }
    }
    
    
    // Task: Steps in k-primes
    // Ref: 5a48948e145c46820b00002f
    func isPrime(_ number: Int) -> Bool {
        let checkUntil = Int(sqrt(Double(number)))
        var index = 0
        while index < primes.count && primes[index] <= checkUntil {
            if number % primes[index] == 0 {
                return false
            }
            index += 1
        }
        return true
    }

    func fillPrimes(until topBorder: Int) {
        var index = 2
        let checkUntil = Int(sqrt(Double(topBorder)))
        while index <= checkUntil {
            if isPrime(index) {
                primes.append(index)
            }
            index += 1
        }
    }

    func getKPrime(_ number: Int) -> Int {
        let checkUntil = Int(sqrt(Double(number)))
        var index = 0
        while index < primes.count && primes[index] <= checkUntil {
            if number % primes[index] == 0 {
                return 1 + getKPrime(number / primes[index])
            }
            index += 1
        }
        return 1
    }

    func kprimesStep(_ k: Int, _ step: Int, _ m: Int, _ n: Int) -> [(Int, Int)]? {
        fillPrimes(until: n)
        var kPrimeIndexes = [Int]()
        var result = [(Int, Int)]()
        (m...n).forEach { index in
            let kPrimeCount = getKPrime(index)
            if kPrimeCount == k {
                if let previousIndex = kPrimeIndexes.last(where: { lastPrime in index - lastPrime == step }) {
                    result.append((previousIndex, index))
                }
                kPrimeIndexes.append(index)
            }
            
        }
        return result.isEmpty ? nil : result
    }
    
    // Task: Good vs Evil
    // Ref: 52761ee4cffbc69732000738
    func evaluate(good: String, vsEvil evil: String) -> String {
      func score(_ input: String,_ worth: Array<Int>) -> Int {
            var index = 0
            return input.split(separator: " ").compactMap { Int($0) }.reduce(0) {
                let next = $1 * worth[index]
                index += 1
                return $0 + next
            }
        }
        let goodWorth = [1, 2, 3, 3, 4, 10]
        let evilWorth = [1, 2, 2, 2, 3, 5, 10]
        switch score(good, goodWorth) - score(evil, evilWorth) {
        case 0: return "Battle Result: No victor on this battle field"
        case 1...: return "Battle Result: Good triumphs over Evil"
        default: return "Battle Result: Evil eradicates all trace of Good"
        }
    }
    
    // Task: Find the missing letter
    // Ref: 5839edaa6754d6fec10000a2
    func findMissingLetter(_ chArr: [Character]) -> Character {
        var prev: UInt8?
        for cur in chArr {
            if let prev {
                if let current = cur.asciiValue {
                    if current - prev > 1 {
                        return Character(UnicodeScalar(prev + 1))
                    }
                }
            }
            prev = cur.asciiValue
        }
        return "0"
    }
    
    // Task: Find the unique number
    // Ref: 585d7d5adb20cf33cb000235
    func findUniq(_ arr: [Int]) -> Int {
        var numbers = [Int: Int]()
        for item in arr {
            numbers[item] = numbers[item, default: 0] + 1
            if numbers.count > 1, numbers.values.first(where: { $0 > 1}) != nil {
                return numbers.first(where: { key, value in value == 1})?.key ?? 0
            }
        }
        return 0 // unique integer in the array
    }
    
    // Task: If you can read this...
    // Ref: 586538146b56991861000293
    func toNato(_ words: String) -> String {
        let NATO = [Character("a") : "b"]
        return words.uppercased().compactMap {
            let str = String($0)
            if $0.isLetter {
                return NATO[$0]
            } else if ",.!?".contains(str) {
                return str
            } else {
                return nil
            }
        }.joined(separator: " ")
    }
    
    // Task: Find the missing term in an Arithmetic Progression
    // Ref: 52de553ebb55d1fca3000371
    func find_missing(l:[Int]) -> Int {
        let first = l.first ?? 0
        let last = l.last ?? 0
        let sum = (last + first) * (l.count + 1) / 2
        return sum - l.reduce(0, +)
    }
    
    // Task: Color Choice
    // Ref: 55be10de92aad5ef28000023
    func checkChoose(_ m: Int, _ n: Int) -> Int {
        var curSum = 1
        var curProbe = 0
        while true {
            if curSum == m { return curProbe }
            if curSum > m || curProbe > n / 2 + 1 { return -1 }
            curProbe += 1
            curSum = curSum * (n - curProbe + 1) / curProbe
        }
    }
}

var primes = [Int]()
