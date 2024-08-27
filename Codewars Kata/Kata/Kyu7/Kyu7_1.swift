//
//  Kyu7_1.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 26.02.2023.
//

import Foundation

enum Kyu7_1 {
    case one
    // Task: Flatten and sort an array
    // Ref: 57ee99a16c8df7b02d00045f
    func flattenAndSort<T: Comparable>(_ arr: [[T]]) -> [T] {
        arr.reduce([T](), +).sorted()
    }
    
    // Task: Resistor Color Codes
    // Ref: 57cf3dad05c186ba22000348
    func decodeResistorColors(_ bands: String) -> String {
        func decodeWord(_ word: String.SubSequence) -> Double {
            switch word {
            case "black": return 0
            case "brown": return 1
            case "red": return 2
            case "orange": return 3
            case "yellow": return 4
            case "green": return 5
            case "blue": return 6
            case "violet": return 7
            case "gray": return 8
            case "white": return 9
            default:
                fatalError("Unknown word")
            }
        }
        
        let words = bands.split(separator: " ")
        var tolerance = 20
        if words.count > 3 {
            switch words[3] {
            case "gold": tolerance = 5
            case "silver": tolerance = 10
            default:
                fatalError("Unknown word")
            }
        }
        
        var resistance = decodeWord(words[0]) * 10 + decodeWord(words[1])
        let power = pow(10, decodeWord(words[2]))
        resistance *= power
        var result = ""
        var resStr = ""
        if resistance < 1000.0 {
            resStr = String(format: "%g", resistance)
        } else if resistance < 1000000.0 {
            resStr = String(format: "%gk", resistance/1000.0)
        } else {
            resStr = String(format: "%gM", resistance/1000000.0)
        }
        
        result = "\(resStr) ohms, \(tolerance)%"
            
        return result
    }
    
    // Task: Balanced Number (Special Numbers Series #1 )
    // Ref: 5a4e3782880385ba68000018
    func balancedNumber(_ number: Int) -> String {
      var tmp = number
        var digits = [Int]()
        while tmp > 0 {
            digits.append(tmp % 10)
            tmp /= 10
        }
        
        guard digits.count > 2 else {
            return "Balanced"
        }
        
        var sum = 0
        for i in 0..<((digits.count - 1) / 2) {
            sum += digits[i]
            sum -= digits[digits.count - i - 1]
        }
        return sum == 0 ? "Balanced" : "Not Balanced"
    }
    
    // Task: Shortest Word
    // Ref: 57cebe1dc6fdc20c57000ac9
    func find_short(_ str: String) -> Int
    {
      str.split(separator: " ").min { $0.count < $1.count }?.count ?? 0
    }
    
    // Task: Sum of Minimums!
    // Ref: 5d5ee4c35162d9001af7d699
    func sumOfMinimums(_ numbers: [[Int]]) -> Int {
        numbers.reduce(0) { acc, element in
            acc + (element.min() ?? 0)
        }
    }
    
    // Task: Sum of integers in string
    // Ref: 598f76a44f613e0e0b000026
    func sumOfIntegersInString(_ string: String) -> Int {
      string.split(separator: try! Regex("[^0-9]")).compactMap{ Int($0) }.reduce(0, +)
    }
    
    // Task: Descending Order
    // Ref: 5467e4d82edf8bbf40000155
    func descendingOrder(of number: Int) -> Int {
        String(number).compactMap { $0.wholeNumberValue }.sorted(by: >).reduce(0) { $0*10 + $1 }
    }
    
    // Task: Strong Number (Special Numbers Series #2)
    // Ref: 5a4d303f880385399b000001
    func strongNumber(_ number: Int) -> String {
        let factMap = [0:0, 1:1, 2:2, 3:6, 4:24, 5:120, 6:720, 7:5040, 8:40320, 9:362880]
        let factSum = String(number).compactMap { $0.wholeNumberValue }.reduce(0) { $0 + (factMap[$1] ?? 0) }
        return factSum == number ? "STRONG!!!!" : "Not Strong !!"
    }
    
    // Task: Linked Lists - Push & BuildOneTwoThree
    // Ref: 55be95786abade3c71000079
    class Node {
        var data: Int
        var next: Node?
        
        init(_ data: Int) {
            self.data = data;
        }
    }

    func push(_ head:Node?, _ data:Int) -> Node {
        let result = Node(data)
        result.next = head
        return result
    }

    func buildOneTwoThree() -> Node {
        push(push(push(nil, 3), 2), 1)
    }
    
    // Task: Extra Perfect Numbers (Special Numbers Series #7)
    // Ref: 5a662a02e626c54e87000123
    func extraPerfect(_ n: Int) -> [Int] {
      Array(0...(n - 1) / 2).map { $0 * 2 + 1 }
    }
    
    // Task: Count the divisors of a number
    // Ref: 542c0f198e077084c0000c2e
    func minDivisor(_ n: UInt32) -> UInt32 {
        let max = UInt32(sqrt(Double(n)) + 1)
        for probe in 2...max {
            if n % probe == 0 {
                return probe
            }
        }
        return n
    }

    func divisors(_ n: UInt32) -> UInt32 {
        guard n != 0 && n != 1 else { return n}
        var remainder = n
        var divisors = [UInt32 : UInt32]()
        while remainder != 1 {
            let minDiv = minDivisor(remainder)
            divisors[minDiv] = (divisors[minDiv] ?? 1) + 1
            remainder /= minDiv
        }
        return divisors.values.reduce(1) { $0 * $1 }
    }
    
    // Task: Simple Fun #152: Invite More Women?
    // Ref: 58acfe4ae0201e1708000075
    func inviteMoreWomen(_ arr: [Int]) -> Bool {
      arr.reduce(0, +) > 0
    }
    
    // Task: Credit Card Mask
    // Ref: 5412509bd436bd33920011bc
    func maskify(_ string:String) -> String {
        guard string.count > 4 else { return string }
        let first = String(repeating: "#", count: string.count - 4)
        let second = string.suffix(4)
        return first + second
    }
    
    // Task: Valid Parentheses
    // Ref: 6411b91a5e71b915d237332d
    func validParentheses(_ str: String) -> Bool {
        var openBraces = 0
        var valid = true
        str.forEach {
            if $0 == "(" {
                openBraces += 1
            } else if $0 == ")" {
                openBraces -= 1
                if openBraces < 0 {
                    valid = false
                }
            }
        }
        return valid && openBraces == 0
    }
    
    // Task: Spacify
    // Ref: 57f8ee485cae443c4d000127
    func spacify(_ str: String) -> String {
        str.map { String($0) }.joined(separator: " ")
    }
    
    // Task: Correct the time-string
    // Ref: 57873ab5e55533a2890000c7
    func correct(_ timeString: String?) -> String? {
        guard let timeString, !timeString.isEmpty else { return timeString }
        let digits = timeString.split(separator: ":").compactMap { Int($0) }
        guard digits.count == 3 else { return nil }
        let correctSeconds = digits[2] % 60
        let correctMinutes = (digits[1] + digits[2] / 60) % 60
        let correctHours = (digits[0] + (digits[1] + digits[2] / 60) / 60) % 24
        return String(format: "%02d:%02d:%02d", correctHours, correctMinutes, correctSeconds)
    }
    
    // Task: Printer Errors
    // Ref: 56541980fa08ab47a0000040
    func printerError(_ s: String) -> String {
        "\(s.filter{ $0 > "m" }.count)/\(s.count)"
    }
    
    // Task: Replace all items
    // Ref: 57ae18c6e298a7a6d5000c7a
    func replaceAll<T: Equatable>(array: [T], old: T, new: T) -> [T] {
      array.replacing([old], with: [new])
    }
    
    // Task: Bases Everywhere
    // Ref: 5f47e79e18330d001a195b55
    func baseFinder(_ seq: [String]) -> Int {
        (seq.map { $0.last?.wholeNumberValue ?? 0 }.max() ?? 0) + 1
    }
    
    // Task: Simple Fun #2: Circle of Numbers
    // Ref: 58841cb52a077503c4000015
    func circleOfNumbers(_ n: Int, _ fst: Int) -> Int {
        (fst + n / 2) % n
    }
    
    // Task: Mumbling
    // Ref: 5667e8f4e3f572a8f2000039
    func accum(_ s: String) -> String {
        var repeatCount = 0
        var ar = [String]()
        s.forEach {
            ar.append($0.uppercased() + String(repeating: $0.lowercased().first!, count: repeatCount))
            repeatCount += 1
        }
        return ar.joined(separator: "-")
    }
    
    // Task: Functional Addition
    // Ref: 538835ae443aae6e03000547
    func add(_ n: Int) -> ((Int) -> Int) {
      { $0 + n }
    }
    
    // Task: Find the nth Digit of a Number
    // Ref: 577b9960df78c19bca00007e
    func findDigit(_ num:Int, _ nth: Int) -> Int {
        guard nth > 0 else { return -1}
        let value = String(abs(num)).map { $0 }
        if nth <= value.count {
            return value[value.count - nth].wholeNumberValue ?? 0
        } else {
            return 0
        }
    }
    
    // Task: Over The Road
    // Ref: 5f0ed36164f2bc00283aed07
    func overTheRoad(address: Int, street: Int) -> Int {
      2 * street - address + 1
    }
    
    // Task: Triangular Treasure
    // Ref: 525e5a1cb735154b320002c8
    func triangular(_ n: Int) -> Int{
      if n > 0 { return (n + 1) * n / 2 } else { return 0 }
    }
    
    // Task: Drone Fly-By
    // Ref: 58356a94f8358058f30004b5
    func flyBy(lamps: String, drone: String) -> String {
        let oCount = min(lamps.count, drone.count)
        return String(repeating: "o", count: oCount) + String(repeating: "x", count: lamps.count - oCount)
    }
    
    // Task: Number of Decimal Digits
    // Ref: 58fa273ca6d84c158e000052
    func digits(num n: UInt64) -> Int {
      String(n).count
    }
    
    // Task: Going to the cinema
    // Ref: 562f91ff6a8b77dfe900006e
    func movie(card: Double, ticket: Double, perc: Double) -> Int {
        var step = 1
        var systemASum = ticket
        var systemBTicket = Double(ticket) * perc
        var systemBSum = Double(card) + systemBTicket
        while systemASum <= systemBSum.rounded(.up) {
            systemASum += ticket
            systemBTicket *= perc
            systemBSum += systemBTicket
            step += 1
        }
        return step
    }
    
    // Task: Count the Digit
    // Ref: 566fc12495810954b1000030
    func nbDig(_ n: Int, _ d: Int) -> Int {
        let dChar = String(d).first
        return (0...n).reduce(0) { acc, el in
            acc + String(el*el).filter { $0 == dChar }.count
        }
    }
    
    // Task: Drying Potatoes
    // Ref: 58ce8725c835848ad6000007
    func potatoes (_ p0: Int, _ w0: Int, _ p1: Int) -> Int {
       w0 * (100 - p0) / (100 - p1)
    }
    
    // Task: Square Every Digit
    // Ref: 546e2562b03326a88e000020
    func squareDigits(_ num: Int) -> Int {
      Int(String(num).compactMap{ $0.wholeNumberValue }.map { String($0 * $0) }.joined()) ?? 0
    }
    
    // Task: Disemvowel Trolls
    // Ref: 52fba66badcd10859f00097e
    func disemvowel(_ s: String) -> String {
      s.filter { !"aeiouAEIOU".contains($0) }
    }
    
    // Task: Counting in the Amazon
    // Ref: 55b95c76e08bd5eef100001e
    func countArare(_ n: Int) -> String {
        print("Input = \(n)")
        guard n > 0 else { return "" }
        var wordArray = Array(repeating: "adak", count: n / 2)
        if n % 2 == 1 {
            wordArray.append("anane")
        }
        return wordArray.joined(separator: " ")
    }
    
    // Task: The 'spiraling' box
    // Ref: 63b84f54693cb10065687ae5
    func createBox(_ m:Int, _ n:Int) -> [[Int]] {
      (0..<n).map { iN in
            (0..<m).map { iM in
                let mPos = min(iM + 1, m - iM)
                let nPos = min(iN + 1, n - iN)
                return min(nPos, mPos)
            }
        }
    }
    
    // Task: Numbers with this digit inside
    // Ref: 57ad85bb7cb1f3ae7c000039
    func numbersWithDigitInside(_ x: Int64, _ d: Int64) -> [Int64] {
      let numbers = (1...x).filter{ "\($0)".contains("\(d)") }
      return [Int64(numbers.count), numbers.reduce(0,+), numbers.isEmpty ? 0 : numbers.reduce(1, *)]
    }
    
    // Task: Finding length of the sequence
    // Ref: 5566b0dd450172dfc4000005
    func lengthOfSequence(_ arr:[Int], _ key:Int) -> Int {
        var keyIndexes = [Int]()
        for index in arr.indices {
            if arr[index] == key {
                keyIndexes.append(index)
            }
        }
        guard keyIndexes.count == 2 else { return 0 }
        return keyIndexes[1] - keyIndexes[0] + 1
    }
    
    // Task: Partial Word Searching
    // Ref: 54b81566cd7f51408300022d
    func wordSearch(_ str:String, _ arr:[String]) -> [String] {
        let result = arr.filter { $0.lowercased().contains(str.lowercased()) }
        return result.isEmpty ? ["Empty"] : result
    }
    
    // Task: Binary Calculator
    // Ref: 546ba103f0cf8f7982000df4
    enum Operator {
        case ADD, SUBTRACT, MULTIPLY
    }

    func calculate(_ a:String, _ b:String, _ op:Operator) -> String {
        guard let aDig = Int(a, radix: 2), let bDig = Int(b, radix: 2) else { return "Error" }
        let resultDig: Int
        switch op {
        case .ADD: resultDig = aDig + bDig
        case .SUBTRACT: resultDig = aDig - bDig
        case.MULTIPLY: resultDig = aDig * bDig
        }
        return String(resultDig, radix: 2)
    }
    
    // Task: ToLeetSpeak
    // Ref: 57c1ab3949324c321600013f
    func toLeetSpeak(_ s : String) -> String {
        s.compactMap { LeetMap[String($0)] ?? " "}.joined(separator: "")
    }
    
    // Task: Simple Fun #74: Growing Plant
    // Ref: 58941fec8afa3618c9000184
    func growingPlant(_ upSpeed: Int, _ downSpeed: Int, _ desiredHeight: Int) -> Int {
      upSpeed >= desiredHeight ? 1 : (desiredHeight - downSpeed - 1) / (upSpeed - downSpeed) + 1
    }
    
    // Task: Waiting room
    // Ref: 542f0c36d002f8cd8a0005e5
    func lastChair(_ n: Int) -> Int {
      n - 1
    }
    
    // Task: Minimum Perimeter of a Rectangle
    // Ref: 5826f54cc60c7e5266000baf
    func minimumPerimeter(_ area: Int64) -> Int64 {
        let max = Int64(sqrt(Double(area)))
        var minPerimeter = Int64.max
        for i in 1...max {
            if area % i == 0 {
                minPerimeter = min(minPerimeter, (i + area / i) * 2)
            }
        }
        return minPerimeter
    }
    
    // Task: Linked Lists - Get Nth Node
    // Ref: 55befc42bfe4d13ab1000007
    func getNth(_ head: Node?, _ index: Int) throws -> Node? {
        guard index >= 0, head != nil else { throw "Invalid index" }
        var current = head
        var remainder = index
        while remainder > 0 && current != nil {
            current = current?.next
            remainder -= 1
        }
        if current == nil {
            throw "Invalid index"
        }
        return current
    }
    
    // Task: Factorial
    // Ref: 57a049e253ba33ac5e000212
    func factorial(_ n: Int) -> UInt64 {
      n == 0 || n == 1 ? 1 : UInt64(n) * factorial(n - 1)
    }

    // Task: Find all non-consecutive numbers
    // Ref: 58f8b35fda19c0c79400020f
    func allNonConsecutive (_ arr: [Int]) -> [(Int, Int)] {
      arr.indices.compactMap {
        $0 > 0 && arr[$0 - 1] + 1 != arr[$0] ? ($0, arr[$0]) : nil
      }
    }
    
    // Task: Heron's formula
    // Ref: 57aa218e72292d98d500240f
    func heron(_ a: Double, _ b: Double, _ c: Double) -> Double {
      let s = (a + b + c) / 2
        return sqrt(s * (s - a) * (s - b) * (s - c))
    }
}

// Task: Jaden Casing Strings
// Ref: 5390bac347d09b7da40006f6
extension String {
    func toJadenCase() -> String {
        split(separator: " ").map {
            $0.prefix(1).uppercased() + $0.dropFirst()
        }.joined(separator: " ")
    }
}

extension String: Error {}

let LeetMap = [
  "A" : "@",
  "B" : "8",
  "C" : "(",
  "D" : "D",
  "E" : "3",
  "F" : "F",
  "G" : "6",
  "H" : "#",
  "I" : "!",
  "J" : "J",
  "K" : "K",
  "L" : "1",
  "M" : "M",
  "N" : "N",
  "O" : "0",
  "P" : "P",
  "Q" : "Q",
  "R" : "R",
  "S" : "$",
  "T" : "7",
  "U" : "U",
  "V" : "V",
  "W" : "W",
  "X" : "X",
  "Y" : "Y",
  "Z" : "2"
]
