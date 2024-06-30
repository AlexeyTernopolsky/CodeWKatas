//
//  Kyu8_1.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 26.02.2023.
//

import Foundation

enum Kyu8_1 {
    // Task: Grasshopper - Messi goals function
    // Ref: 55f73be6e12baaa5900000d4
    func goals(laLigaGoals: Int, copaDelReyGoals: Int, championsLeagueGoals: Int) -> Int {
        return laLigaGoals + copaDelReyGoals + championsLeagueGoals
    }
    
    // Task: Square(n) Sum
    // Ref: 515e271a311df0350d00000f
    func squareSum(_ vals: [Int]) -> Int {
        vals.map { $0*$0 }.reduce(0, +)
    }
    
    // Task: Sum The Strings
    // Ref: 5966e33c4e686b508700002d
    func sum_str(_ a:String, _ b:String) -> String {
        String((Int(a) ?? 0) + (Int(b) ?? 0))
    }
    
    // Task: Reversed Strings
    // Ref: 5168bb5dfe9a00b126000018
    func reverse(_ str: String) -> String {
        String(str.reversed())
    }
    
    // Task: Convert a Number to a String!
    // Ref: 5265326f5fda8eb1160004c8
    func numberToString(number: Int) -> String {
        String(number)
    }
    
    // Task: Beginner - Lost Without a Map
    // Ref: 57f781872e3d8ca2a000007e
    func maps(a : Array<Int>) -> Array<Int> {
        a.map { $0*2}
    }
    
    // Task: Count the Monkeys!
    // Ref: 56f69d9f9400f508fb000ba7
    func monkeyCount(_ n: Int) -> [Int] {
        var ret = [Int]()
        for i in 1...n {
            ret.append(i)
        }
        return ret
    }
    
    // Task: Beginner - Reduce but Grow
    // Ref: 57f780909f7e8e3183000078
    func grow(_ arr: [Int]) -> Int {
        arr.reduce(1, *)
    }
    
    // Task: Gravity Flip
    // Ref: 5f70c883e10f9e0001c89673
    func flip(_ direction: String, _ a: [Int]) -> [Int] {
        let askending = direction == "R"
        return a.sorted { askending ? $0 < $1 : $0 > $1 }
    }
    
    // Task: String repeat
    // Ref: 57a0e5c372292dd76d000d7e
    func repeatStr(_ n: Int, _ string: String) -> String {
        Array(repeating: string, count: n).joined()
    }
    
    // Task: Get the mean of an array
    // Ref: 563e320cee5dddcf77000158
    func getAverage(_ marks: [Int]) -> Int {
        marks.reduce(0, +) / marks.count
    }
    
    // Task: Sum of positive
    // 5715eaedb436cf5606000381
    func sumOfPositives (_ numbers: [Int] ) -> Int {
        numbers.reduce(0) { $0 + ($1 > 0 ? $1 : 0) }
    }
    
    // Task: Miles per gallon to kilometers per liter
    // Ref: 557b5e0bddf29d861400005d
    func converter(mpg: Int) -> Double {
        Double(mpg) * 1.609344 / 4.54609188
    }
    
    // Task: Sum Mixed Array
    // Ref: 57eaeb9578748ff92a000009
    func sumMix(_ arr: [Any]) -> Int {
        arr.reduce(0) { acc, next in
            if let number = next as? Int {
                return acc + number
            } else if let strNumber = next as? String {
                return acc + (Int(strNumber) ?? 0)
            } else {
                return acc
            }
        }
    }
    
    // Task: Convert number to reversed array of digits
    // Ref: 5583090cbe83f4fd8c000051
    func digitize(_ num:Int) -> [Int] {
        var res = [Int]()
        var t = num
        while t > 0 {
            res.append(t % 10)
            t /= 10
        }
        if res.isEmpty {
            res.append(0)
        }
        return res
    }
    
    // Task: A wolf in sheep's clothing
    // Ref: 5c8bfa44b9d1192e1ebd3d15
    func warnTheSheep(_ queue: [String]) -> String {
        let index = queue.lastIndex { $0 == "wolf" }!
        if index == queue.count - 1 {
            return "Pls go away and stop eating my sheep"
        } else {
            return "Oi! Sheep number \(queue.count - index - 1)! You are about to be eaten by a wolf!"
        }
    }
    
    // Task: Dollars and Cents
    // Ref: 55902c5eaa8069a5b4000083
    func formatMoney(_ val:Double) -> String {
        NSString(format: "$%.02f", val) as String
    }
    
    // Task: Returning Strings
    // Ref: 55a70521798b14d4750000a4
    func greet(_ name: String) -> String {
        return "Hello, \(name) how are you doing today?"
    }
    
    // Task: Enumerable Magic #25 - Take the First N Elements
    // Ref: 545afd0761aa4c3055001386
    func take(_ arr: [Int], _ n: Int) -> [Int] {
        [Int](arr.prefix(n))
    }
    
    // Task: Stringy Strings
    // Ref: 563b74ddd19a3ad462000054
    func stringy(_ size: Int) -> String {
        var str = String(repeating: "10", count: size / 2)
        if size % 2 == 1 {
            str += "1"
        }
        return str
    }
    
    // Task: BASIC: Making Six Toast.
    // Ref: 5834fec22fb0ba7d080000e8
    func sixToast(_ num: Int) -> Int {
        abs(6 - num)
    }
    
    // Task: To square(root) or not to square(root)
    // Ref: 57f6ad55cca6e045d2000627
    func squareOrSquareRoot(_ input: [Int]) -> [Int] {
        input.map {
            let sq = Int(Double($0).squareRoot())
            return sq*sq == $0 ? sq : $0 * $0
        }
    }
    
    // Task: Is he gonna survive?
    // Ref: 59ca8246d751df55cc00014c
    func hero(bullets: Int, dragons: Int) -> Bool {
        bullets >= dragons * 2
    }
    
    // Task: Get Planet Name By ID
    // Ref: 515e188a311df01cba000003
    func getPlanetName(_ id: Int) -> String {
        var name:String
        switch id {
        case 1:
            name = "Mercury"
        case 2:
            name = "Venus"
        case 3:
            name = "Earth"
        case 4:
            name = "Mars"
        case 5:
            name = "Jupiter"
        case 6:
            name = "Saturn"
        case 7:
            name = "Uranus"
        case 8:
            name = "Neptune"
        default:
            name = ""
        }
        return name
    }
    
    // Task: Difference of Volumes of Cuboids
    // Ref: 58cb43f4256836ed95000f97
    func findDifference(_ a: [Int], _ b: [Int]) -> Int {
        abs(a.reduce(1, *) - b.reduce(1, *))
    }
    
    // Task: Fake Binary
    // Ref: 57eae65a4321032ce000002d
    func fakeBin(digits: String) -> String {
        digits.map { $0 >= "5" ? "1" : "0" }.joined()
    }
    
    // Task: Volume of a Cuboid
    // Ref: 58261acb22be6e2ed800003a
    func getVolumeOfCuboid(length: Int, width: Int, height: Int) -> Int {
        length * width * height
    }
    
    // Task: You Can't Code Under Pressure #1
    // Ref: 53ee5429ba190077850011d4
    func doubleInteger(_ num: Int) -> Int {
        num * 2
    }
    
    // Task: Find the first non-consecutive number
    // Ref: 58f8a3a27a5c28d92e000144
    func firstNonConsecutive (_ arr: [Int]) -> Int? {
        var prev = arr.first ?? 0
        for i in 1..<arr.count {
            if arr[i] != prev + 1 {
                return arr[i]
            } else {
                prev = arr[i]
            }
        }
        return nil
    }
    
    // Task: Remove First and Last Character
    // Ref: 56bc28ad5bdaeb48760009b0
    func removeFirstAndLast(_ str: String) -> String {
        String(str.dropFirst().dropLast())
    }
    
    // Task: Simple multiplication
    // Ref: 583710ccaa6717322c000105
    func simpleMultiplication(_ num: Int) -> Int {
        num * (8 + num % 2)
    }
    
    // Task: Quarter of the year
    // Ref: 5ce9c1000bab0b001134f5af
    func quarter(of month: Int) -> Int {
        (month - 1) / 3 + 1
    }
    
    // Task: Convert a Boolean to a String
    // Ref: 551b4501ac0447318f0009cd
    func booleanToString(_ b: Bool) -> String {
        "\(b)"
    }
    
    // Task: Calculate BMI
    // Ref: 57a429e253ba3381850000fb
    func bmi(_ weight: Int, _ height: Double) -> String {
        let bmiVal = Double(weight) / height / height
        switch bmiVal {
        case ...18.5: return "Underweight"
        case ...25.0: return "Normal"
        case ...30.0: return "Overweight"
        default: return "Obese"
        }
    }
    
    // Task: Convert boolean values to strings 'Yes' or 'No'.
    // Ref: 53369039d7ab3ac506000467
    func boolToWord(_ bool: Bool) -> String {
        bool ? "Yes" : "No"
    }
    
    // Task: Opposite number
    // Ref: 56dec885c54a926dcd001095
    func opposite(number: Double) -> Double {
        -number
    }
    
    // Task: Reversed sequence
    // Ref: 5a00e05cc374cb34d100000d
    func reverseSeq(n: Int) -> [Int] {
        Array(1...n).reversed()
    }
    
    // Task: Thinkful - Logic Drills: Traffic light
    // Ref: 58649884a1659ed6cb000072
    func update_light(_ current: String) -> String {
        ["green" : "yellow", "yellow" : "red", "red" : "green"][current] ?? ""
    }
    
    // Task: Get Nth Even Number
    // Ref: 5933a1f8552bc2750a0000ed
    func nthEven(_ n: Int) -> Int {
        (n - 1) * 2
    }
    
    // Task: Function 2 - squaring an argument
    // Ref: 523b623152af8a30c6000027
    func square(_ num: Int) -> Int {
        num * num
    }
    
    // Task: Third Angle of a Triangle
    // Ref: 5a023c426975981341000014
    func otherAngle(a: Int, b: Int) -> Int {
        180 - a - b
    }
    
    // Task: Switch it Up!
    // Ref: 5808dcb8f0ed42ae34000031
    func switchItUp(_ number: Int) -> String {
        switch number {
        case 0: return "Zero"
        case 1: return "One"
        case 2: return "Two"
        case 3: return "Three"
        case 4: return "Four"
        case 5: return "Five"
        case 6: return "Six"
        case 7: return "Seven"
        case 8: return "Eight"
        case 9: return "Nine"
        default: return "Not supported"
        }
    }
    
    // Task: You only need one - Beginner
    // Ref: 57cc975ed542d3148f00015b
    func check<T: Equatable>(_ a: [T], _ x: T) -> Bool {
        a.contains(x)
    }
    
    // Task: Multiplication table for number
    // Ref: 5a2fd38b55519ed98f0000ce
    func multi_table(_ number: Int) -> String {
        (1...10).map { "\($0) * \(number) = \($0*number)\($0 == 10 ? "" : "\n")" }.joined()
    }
    
    // Task: Grasshopper - Grade book
    // Ref: 55cbd4ba903825f7970000f5
    func getGrade(_ s1: Int, _ s2: Int, _ s3: Int) -> String {
        switch (s1 + s2 + s3) / 3 {
        case 90...100: return "A"
        case 80..<90: return "B"
        case 70..<80: return "C"
        case 60..<70: return "D"
        case 0..<60: return "F"
        default: return "Not supported"
        }
    }
    
    // Task: Grasshopper - Personalized Message
    // Ref: 5772da22b89313a4d50012f7
    func great(_ name: String, _ owner: String) -> String {
        "Hello \(name == owner ? "boss" : "guest")"
    }
    
    // Task: Transportation on vacation
    // Ref: 568d0dd208ee69389d000016
    func RentalCarCost(_ days: Int) -> Int {
        switch days {
        case ...2: return days * 40
        case 3..<7: return days * 40 - 20
        default: return days * 40 - 50
        }
    }
    
    // Task: Multiply
    // Ref: 50654ddff44f800200000004
    func multiply(_ a: Double, _ b: Double) -> Double {
        a * b
    }
    
    // Task: Even or Odd
    // Ref: 53da3dbb4a5168369a0000fe
    func evenOrOdd(_ number:Int) -> String {
        number % 2 == 0 ? "Even" : "Odd"
    }
    
    // Task: Grasshopper - Summation
    // Ref: 55d24f55d7dd296eb9000030
    func summation(_ n: Int) -> Int {
        (n + 1) * n / 2
    }
    
    // Task: Grasshopper - Terminal game move function
    // Ref: 563a631f7cbbc236cf0000c2
    func move(_ p: Int, _ r: Int) -> Int {
        p + r*2
    }
    
    // Task: Is n divisible by x and y?
    // Ref: 5545f109004975ea66000086
    func isDivisible(_ n: Int, _ x: Int, _ y: Int) -> Bool {
        n.isMultiple(of: x) && n.isMultiple(of: y)
    }
    
    // Task: Expressions Matter
    // Ref: 5ae62fcf252e66d44d00008e
    func expressionMatter(_ a: Int, _ b: Int, _ c: Int) -> Int {
        [a + b + c, a * (b + c), (a + b) * c, a * b * c].max() ?? 0
    }
    
    // Task: Grasshopper - Check for factor
    // Ref: 55cbc3586671f6aa070000fb
    func checkForFactor(_ base: Int, _ factor: Int) -> Bool {
        base % factor == 0
    }
    
    // Task: Function 1 - hello world
    // Ref: 523b4ff7adca849afe000035
    func greet() -> String {
        "hello world!"
    }
    
    // Task: Century From Year
    // Ref: 5a3fe3dde1ce0e8ed6000097
    func century(_ year: Int) -> Int {
        (year - 1) / 100 + 1
    }
    
    // Task: Beginner Series #2 Clock
    // Ref: 55f9bca8ecaa9eac7100004a
    func past(_ h: Int, _ m: Int, _ s: Int) -> Int {
        ((h * 60 + m) * 60 + s) * 1000
    }
    
    // Task: Never visit a . . . !?
    // Ref: 56c5847f27be2c3db20009c3
    func subtractSum(_ n: Int) -> String {
        "apple"
    }
}
