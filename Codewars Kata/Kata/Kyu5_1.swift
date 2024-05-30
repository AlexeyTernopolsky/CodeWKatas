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
}
