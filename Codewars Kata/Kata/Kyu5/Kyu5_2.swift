//
//  Kyu5_2.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 29.08.2024.
//

import Foundation

enum Kyu5_2 {
    case one
    // Task: My smallest code interpreter (aka Brainf**k)
    // Ref:  https://www.codewars.com/kata/526156943dfe7ce06200063e
    func brainLuck(_ code: String, input: String) -> String {
        var memory = Array<UInt8>(repeating: 0, count: 4000)
        var memoryIndex = 0
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
        var opIndex = code.startIndex
        var inputIndex = input.startIndex
        var output = ""
        while opIndex != code.endIndex {
            switch code[opIndex] {
            case ">": memoryIndex += 1
            case "<": memoryIndex -= 1
            case "+": memory[memoryIndex] = memory[memoryIndex] &+ 1
            case "-": memory[memoryIndex] = memory[memoryIndex] &- 1
            case ".": output += String(UnicodeScalar(memory[memoryIndex]))
            case ",":
                memory[memoryIndex] = UInt8(input[inputIndex].unicodeScalars.first?.value ?? 0)
                inputIndex = input.index(after: inputIndex)
            case "[": if memory[memoryIndex] == 0 {
                opIndex = gotoDictionary[opIndex] ?? opIndex
            }
            case "]": if memory[memoryIndex] != 0 {
                opIndex = gotoDictionary[opIndex] ?? opIndex
            }
            default: break
            }
            opIndex = code.index(after: opIndex)
        }
        return output
    }
    
    // Task: Product of consecutive Fib numbers
    // Ref: https://www.codewars.com/kata/5541f58a944b85ce6d00006a
    func productFib(_ prod : UInt64) -> (UInt64,UInt64,Bool) {
        var (a, b) = (UInt64(0), UInt64(1))
        while a*b < prod {
            (a, b) = (b, a + b)
        }
        return (a, b, a*b == prod)
    }
    
    // Task: Diophantine Equation
    // Ref: https://www.codewars.com/kata/554f76dca89983cc400000bb
    func solequa(_ n: Int) -> [(Int, Int)] {
        let max = Int(sqrt(Double(n)))
        var result = [(Int, Int)]()
        for i in 1...max {
            if n % i == 0 {
                let second = n / i
                if (second - i) % 4 == 0 {
                    let y = (second - i) / 4
                    let x = i + 2*y
                    result.append((x, y))
                }
            }
        }
        return result
    }
    
    // Task: Integers: Recreation One
    // Ref: https://www.codewars.com/kata/55aa075506463dac6600010d
    func listSquared(_ m: Int, _ n: Int) -> [(Int, Int)] {
        func divisorsSquareSum(for number: Int) -> Int {
            (1...Int(sqrt(Double(number))))
                .filter { number % $0 == 0 }
                .reduce(0) { sum, item in
                    let second = number / item
                    return sum + item*item + (second == item ? 0 : second * second) }
        }
        
        return (m...n).compactMap {
            let sum = divisorsSquareSum(for: $0)
            let sqrt = Int(sqrt(Double(sum)))
            return sqrt * sqrt == sum ? ($0, sum) : nil
        }
    }
    
    // Task: Consecutive k-Primes
    // Ref: https://www.codewars.com/kata/573182c405d14db0da00064e
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
        var index = (primes.last ?? 1) + 1
        let checkUntil = Int(sqrt(Double(topBorder)))
        while index <= checkUntil {
            if isPrime(index) {
                primes.append(index)
            }
            index += 1
        }
    }

    func primeDivisorsCount(_ number: Int) -> Int {
        guard number >= 2 else { return 0 }
        let max = Int(sqrt(Double(number)))
        var index = 0
        while index < primes.count && primes[index] <= max {
            if number % primes[index] == 0 {
                return 1 + primeDivisorsCount(number / primes[index])
            }
            index += 1
        }
        return 1
    }

    func consecKprimes(_ k: Int, _ arr: [Int]) -> Int {
        fillPrimes(until: arr.max() ?? 0)
        var prevIsKPrime = false
        return arr.map { primeDivisorsCount($0) }.reduce(0) {
            var result = 0
            if $1 == k {
                if prevIsKPrime { result = 1 }
                prevIsKPrime = true
            } else {
                prevIsKPrime = false
            }
            return $0 + result
        }
    }
    
    // Task: Factorial decomposition
    // Ref: https://www.codewars.com/kata/5a045fee46d843effa000070
    func fillPrimesFor(_ number: Int, consumer: (Int) -> Void) {
        guard number > 1 else { return }
        let max = Int(sqrt(Double(number)))
        var index = 0
        while index < primes.count && primes[index] <= max {
            if number % primes[index] == 0 {
                consumer(primes[index])
                fillPrimesFor(number / primes[index], consumer: consumer)
                return
            }
            index += 1
        }
        consumer(number)
    }

    func decomp(_ m: Int) -> String {
        fillPrimes(until: m)
        var primeDict = [Int: Int]()
        for i in 0...m {
            fillPrimesFor(i) {
                primeDict[$0] = primeDict[$0, default: 0] + 1
            }
        }
        return primeDict.keys.sorted().map { key in
            let value = primeDict[key] ?? 0
            return value == 1 ? "\(key)" : "\(key)^\(value)"
        }.joined(separator: " * ")
    }
    
    // Task: Is my friend cheating?
    // Ref: https://www.codewars.com/kata/5547cc7dcad755e480000004
    func removNb(_ n: Int) -> [(Int,Int)] {
        guard n >= 2 else { return [] }
        let sum = (n + 1) * n / 2
        var result = [(Int, Int)]()
        for i in n/2...n {
            let j = (sum - i) / i
            if i * j == sum - i - j {
                result.insert((j, i), at: 0)
                result.append((i, j))
            }
        }
        return result
    }
    
    // Task: Help your granny!
    // Ref: https://www.codewars.com/kata/5536a85b6ed4ee5a78000035
    func tour(_ friends: [String], _ friendsTowns: [String:String], _ dist: [String:Double]) -> Int {
        let towns = friends.compactMap { friendsTowns[$0] }
        var distance = dist[towns.first ?? ""] ?? 0.0
        (1..<towns.count).forEach {
            let c = dist[towns[$0 - 1]] ?? 0.0
            let g = dist[towns[$0]] ?? 0.0
            distance += sqrt(g*g - c*c)
        }
        distance += dist[towns.last ?? ""] ?? 0.0
        return Int(floor(distance))
    }
    
    // Task: Esolang Interpreters #2 - Custom Smallfuck Interpreter
    // Ref: https://www.codewars.com/kata/58678d29dbca9a68d80000d7
    func interpreter(_ code: String, _ tape: String) -> String {
        var chTape = tape.map { $0 == "1" ? 1 : 0 }
        var tapeIndex = 0
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
        var codeIndex = code.startIndex
    globalLoop: while codeIndex != code.endIndex {
            switch code[codeIndex] {
            case ">":
                tapeIndex += 1
                if tapeIndex == chTape.count { break globalLoop }
            case "<":
                tapeIndex -= 1
                if tapeIndex == -1 { break globalLoop }
            case "*": chTape[tapeIndex] = chTape[tapeIndex] == 0 ? 1 : 0
            case "[": if chTape[tapeIndex] == 0 { codeIndex = gotoDictionary[codeIndex]! }
            case "]": if chTape[tapeIndex] != 0 { codeIndex = gotoDictionary[codeIndex]! }
            default: break
            }
            codeIndex = code.index(after: codeIndex)
        }
        return chTape.map { String($0) }.joined(separator: "")
    }
    
    // TasK: Euler's method for a first-order ODE
    // Ref: https://www.codewars.com/kata/56347fcfd086de8f11000014
    func exEuler(_ nb: Int) -> Double {
        let e = 2.71828182845904523536
        func exactSolution(_ x: Double) -> Double {
            1 + 0.5 * pow(e, -4 * x) - 0.5 * pow(e, -2 * x)
        }
        func equration(_ x: Double, _ y: Double) -> Double {
            2 - pow(e, -4 * x) - 2 * y
        }
        let h = 1.0 / Double(nb)
        var y = 1.0
        let result = (1...nb).reduce(0.0) { sum, index in
            let xPrev = Double(index - 1) / Double(nb)
            let x = Double(index) / Double(nb)
            y += equration(xPrev, y) * h
            let z = exactSolution(x)
            return sum + abs(y - z) / z
        } / Double(nb + 1)
        return floor(result * 1000000.0) / 1000000.0
    }
}
