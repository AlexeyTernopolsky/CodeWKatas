//
//  Kyu5_1.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 26.02.2023.
//

import Foundation

enum Kyu5_1 {
    // Task: Perimeter of squares in a rectangle
    // Ref: 559a28007caad2ac4e000083
    func perimeter(_ n: UInt64) -> UInt64 {
        var prevOne: UInt64?
        var prevTwo: UInt64?
        var sum: UInt64 = 0
        for i in 0...n {
            let cur = i < 2 ? 1 : prevOne! + prevTwo!
            sum += cur
            prevTwo = prevOne
            prevOne = cur
        }
        
        return sum * 4
    }
    
    // Task: Convert A Hex String To RGB
    // Ref: 5282b48bb70058e4c4000fa7
    struct RGB: CustomStringConvertible, Equatable {
        var r:Int
        var g:Int
        var b:Int
        init(_ r:Int, _ g:Int, _ b:Int) {
            self.r = r
            self.g = g
            self.b = b
        }
        static func ==(left:RGB, right:RGB) -> Bool {
            return left.r == right.r && left.g == right.g && left.b == right.b
        }
        var description: String {
            return "{R:\(r), G:\(g), B:\(b)}"
        }
    }
    
    func hexStringToRGB(_ str:String) -> RGB {
        var strTmp = ""
        var ar = [UInt8]()
        str.forEach {
            if $0 != "#" {
                strTmp += String($0)
                if strTmp.count == 2 {
                    ar.append(UInt8(strTmp, radix: 16) ?? 0)
                    strTmp = ""
                }
            }
        }
        
        return RGB(Int(ar[0]), Int(ar[1]), Int(ar[2]))
    }
    
    // Task: John and Ann sign up for Codewars
    // Ref: 57591ef494aba64d14000526
    func annAndJohn(_ n: Int) -> ([Int], [Int]) {
        var ann = [1]
        var john = [0]
        if n > 1 {
            for i in 1..<n {
                john.append(i - ann[john[i - 1]])
                ann.append(i - john[ann[i - 1]])
            }
        }
        
        return (ann, john)
    }
    
    func ann(_ n : Int) -> [Int] {
        annAndJohn(n).0
    }
    
    func john(_ n : Int) -> [Int] {
        annAndJohn(n).1
    }
    
    func sumJohn(_ n : Int) -> Int {
        john(n).reduce(0, +)
    }
    
    func sumAnn(_ n : Int) -> Int {
        ann(n).reduce(0, +)
    }
    
    // Task: Primes in numbers
    // Ref: 54d512e62a5e54c96200019e
    func factors(_ number: Int) -> String {
        let sq = Int(sqrt(Double(number)))
        var remain = number
        var probe = 2
        var result = ""
        var primeCount = 0
        
        func handlePrime(_ prime: Int,_ count: Int) {
            switch count {
            case 0: return
            case 1: result += "(\(prime))"
            default: result += "(\(prime)**\(count))"
            }
        }
        
        while probe <= remain && probe <= sq {
            if remain % probe == 0 {
                primeCount += 1
                remain /= probe
            } else {
                handlePrime(probe, primeCount)
                probe += 1
                primeCount = 0
            }
        }
        
        handlePrime(probe, primeCount)
        
        if remain > sq {
            handlePrime(remain, 1)
        }
        
        return result
    }
    
    // Task: Best travel
    // Ref: 55e7280b40e1c4a06d0000aa
    func bestSum(_ target: Int, _ count: Int,_ list: [Int], _ itemCount: Int) -> Int {
        guard count <= itemCount else { return -1 }
        if count == 1 {
            guard list.first! <= target else {return -1}
            guard list[itemCount - 1] > target else {return list[itemCount - 1]}
            for index in stride(from: itemCount - 1, to: -1, by: -1) {
                if list[index] <= target { return list[index] }
            }
        } else {
            let lastItem = list[itemCount - 1]
            var withLast = bestSum(target - lastItem, count-1, list, itemCount - 1)
            if withLast != -1 {
                withLast += lastItem
            }
            
            guard withLast != target else {return target}
            
            return max(withLast, bestSum(target, count, list, itemCount - 1))
        }
        
        return -1
    }
    
    func chooseBestSum(_ t: Int, _ k: Int, _ ls: [Int]) -> Int {
        guard k <= ls.count else { return -1}
        let sList = ls.sorted()
        
        guard sList[0..<k].reduce(0, +) <= t else { return -1 }
        
        return bestSum(t, k, sList, sList.count)
    }
    
    // Task: Greed is Good
    // Ref: 5270d0d18625160ada0000e4
    func score(_ dice: [Int]) -> Int {
        var diceCount = [0, 0, 0, 0, 0, 0]
        dice.forEach { diceCount[$0 - 1] += 1 }
        var result = 0
        if diceCount[0] >= 3 { // 1
            result += 1000 + (diceCount[0] - 3) * 100
        } else {
            result += diceCount[0] * 100
        }
        if diceCount[1] >= 3 { // 2
            result += 200
        }
        if diceCount[2] >= 3 { // 3
            result += 300
        }
        if diceCount[3] >= 3 { // 4
            result += 400
        }
        if diceCount[4] >= 3 { // 5
            result += 500 + (diceCount[4] - 3) * 50
        } else {
            result += diceCount[4] * 50
        }
        if diceCount[5] >= 3 { // 6
            result += 600
        }
        return result
    }
    
    // Task: Number of trailing zeros of N!
    // Ref: 52f787eb172a8b4ae1000a34
    func zeros(_ n: UInt32) -> UInt32 {
        var result = UInt32(0)
        var delimiter = UInt32(5)
        while delimiter < n {
            result += n / delimiter
            delimiter *= 5
        }
        return result
    }
    
    // Task: Find the smallest
    // Ref: 573992c724fc289553000e95
    func smallest(_ n: Int) -> (Int, Int, Int) {
        let originAr = String(n).map { $0.wholeNumberValue }
        var min = n
        var minI = 0
        var minJ = 0
        for i in originAr.indices {
            var changedI = originAr
            let element = changedI.remove(at: i)
            for j in 0...changedI.count {
                var changedJ = changedI
                changedJ.insert(element, at: j)
                if let newValue = Int(changedJ.map { String($0 ?? 0) }.joined(separator: "")) {
                    if newValue < min {
                        min = newValue
                        minI = i
                        minJ = j
                    }
                }
            }
        }
        return (min, minI, minJ)
    }
    
    // Task: Fibo akin
    // Ref: 5772382d509c65de7e000982
    func fillSequence(_ n: Int) -> [Int] {
        let result = NSMutableArray(capacity: n)
        result.add(1)
        result.add(1)
        for i in 2..<n {
            let index1 = i - (result[i - 1] as! Int)
            let index2 = i - (result[i - 2] as! Int)
            result.add((result[index1] as! Int) + (result[index2] as! Int))
        }
        return result as! [Int]
    }
    
    func lengthSupUk(_ n: Int, _ k: Int) -> Int {
        fillSequence(n).filter { $0 >= k }.count
    }
    
    func comp(_ n: Int) -> Int {
        var result = 0
        let sequence = fillSequence(n)
        for i in 1..<n {
            if sequence[i] < sequence[i-1] {
                result += 1
            }
        }
        
        return result
    }
    
    // Task: Going to zero or to infinity?
    // Ref: 55a29405bc7d2efaff00007c
    func going(_ n: Int) -> Double {
        var curValue = 0.0
        for i in 1...n {
            curValue = 1.0 + curValue / Double(i)
        }
        return curValue
    }
    
    // Task: Splitting the Workload (part I)
    // Ref: 587387d169b6fddc16000002
    func splitlist(_ list: [Int]) -> ([Int], [Int]) {
        let sum = list.reduce(0, +)
        let countOfSamples = Int(pow(2.0, Double(list.count)))
        var minDiff = Int.max
        var minSample = 0
        for sample in 0..<countOfSamples {
            var sum1 = sum, sum2 = 0
            for index in list.indices {
                let include = (sample >> index) % 2 == 0
                if include {
                    sum2 += list[index]
                    sum1 -= list[index]
                }
            }
            let diff = abs(sum2 - sum1)
            if diff < minDiff {
                minDiff = diff
                minSample = sample
            }
        }
        var list1 = [Int](), list2 = [Int]()
        for index in list.indices {
            let include = (minSample >> index) % 2 == 0
            if include {
                list1.append(list[index])
            } else {
                list2.append(list[index])
            }
        }
        return (list1, list2)
    }
    
    // Task: Some Egyptian fractions
    // Ref: 54f8693ea58bce689100065f
    struct Fraction {
        let nr: Int64
        let dr: Int64
        
        var representation: String { "\(nr)/\(dr)" }
        var firstGreedyEgyptionFraction: Fraction {
            let newDr = dr % nr == 0 ? dr / nr : (dr / nr) + 1
            return Fraction(nr: 1, dr: newDr)
        }
        
        static func -(_ one: Fraction, two: Fraction) -> Fraction {
            var oneDr = one.dr
            var twoDr = two.dr
            outerloop: repeat {
                if oneDr == 1 || twoDr == 1 {
                    break
                } else {
                    let maxCheck = Int64(sqrt(Double(min(oneDr, twoDr)))) + 1
                    for i in 2...maxCheck {
                        if oneDr % i == 0 && twoDr % i == 0 {
                            oneDr /= i
                            twoDr /= i
                            continue outerloop
                        }
                    }
                    let minNumber = min(oneDr, twoDr)
                    if oneDr % minNumber == 0 && twoDr % minNumber == 0 {
                        oneDr /= minNumber
                        twoDr /= minNumber
                    }
                    break
                }
            } while true
            return Fraction(nr: one.nr * twoDr - two.nr * oneDr, dr: one.dr * twoDr)
        }
        
        mutating func normalize() {
            var newNr = nr
            var newDr = dr
            outerloop: repeat {
                let max = newNr / 2 + 2
                for i in 2...max {
                    if newNr % i == 0 && newDr % i == 0 {
                        newNr /= i
                        newDr /= i
                        continue outerloop
                    }
                }
                if newDr % newNr == 0 {
                  newDr /= newNr
                  newNr = 1
                }
                break
            } while true
            self = Fraction(nr: newNr, dr: newDr)
        }
    }

    func decompose(_ nrStr: String, _ drStr: String) -> String {
        guard var nr = Int64(nrStr), let dr = Int64(drStr), nr > 0, dr > 0 else { return "" }
        var fullPart = nr >= dr ? "\(nr/dr)" : ""
        nr -= (nr / dr) * dr
        guard nr != 0 else { return fullPart }
        if !fullPart.isEmpty { fullPart += "," }
        var lastFraction = Fraction(nr: nr, dr: dr)
        var resultArray = [Fraction]()
        repeat {
            lastFraction.normalize()
            if lastFraction.nr == 1 {
                resultArray.append(lastFraction)
                break
            } else {
                let egyptianFraction = lastFraction.firstGreedyEgyptionFraction
                resultArray.append(egyptianFraction)
                lastFraction = lastFraction - egyptianFraction
            }
        } while true
        return fullPart + resultArray.map{ $0.representation }.joined(separator: ",")
    }
}
