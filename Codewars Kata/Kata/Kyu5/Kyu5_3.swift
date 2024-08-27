//
//  Kyu5_3.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 29.08.2024.
//

import Foundation

enum Kyu5_3 {
    // Task: k-Primes
    // Ref: https://www.codewars.com/kata/5726f813c8dcebf5ed000a6b
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

    func countKprimes(_ k: Int, _ start: Int, _ nd: Int) -> [Int] {
        fillPrimes(until: nd)
        return (start...nd).filter { primeDivisorsCount($0) == k }
    }

    func puzzle(_ s: Int) -> Int {
        guard s >= 138 else { return 0 }
        fillPrimes(until: s)
        var result = 0
        for a in stride(from: s - 10, to: 127, by: -1) {
            if primeDivisorsCount(a) == 7 {
                for b in stride(from: s - a - 2, to: 1, by: -1) {
                    if primeDivisorsCount(b) == 3 && primes.contains(s - a - b) {
                        result += 1
                    }
                }
            }
        }
        return result
    }
}
