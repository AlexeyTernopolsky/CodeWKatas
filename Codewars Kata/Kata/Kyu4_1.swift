//
//  Kyu4_1.swift
//  Codewars Kata
//
//  Created by Alexey Ternopolsky on 27.03.2023.
//

import Foundation

enum Kyu4_1 {
    // Task: Human readable duration format
    // Ref: 52742f58faf5485cae000b9a
    func formatDuration(_ seconds: Int) -> String {
        guard seconds > 0 else {return "now"}
        var items = [String]()
        var cur = seconds
     
        func handleItem(itemCount: Int, single: String, multi: String) {
            if cur > 0 {
                let remain = cur % itemCount
                if remain > 0 {
                    items.insert(remain == 1 ? single : "\(remain) \(multi)", at: 0)
                }
                cur = cur / itemCount
            }
        }
        
        handleItem(itemCount: 60, single: "1 second", multi: "seconds")
        handleItem(itemCount: 60, single: "1 minute", multi: "minutes")
        handleItem(itemCount: 24, single: "1 hour", multi: "hours")
        handleItem(itemCount: 365, single: "1 day", multi: "days")
        handleItem(itemCount: Int.max, single: "1 year", multi: "years")
        
        return items.reduce("") { cur, next in
            cur == "" ? next : "\(cur)\(next == items.last ? " and" : ",") \(next)"
        }
    }
    
    // Task: Path Finder #1: can you reach the exit?
    // Ref: 5765870e190b1472ec0022a2
    enum PosType {
        case empty, filled, wall
    }

    func pathFinder(_ maze: String) -> Bool {
        // prefill the maze
        var mazeAr = [[PosType]]()
        var row = [PosType]()
        for ch in maze {
            switch ch {
            case ".": row.append(.empty)
            case "W": row.append(.wall)
            case "\n":
                mazeAr.append(row)
                row.removeAll()
            default: print(ch)
            }
        }
        
        mazeAr.append(row)
        
        let N = mazeAr.count

        // check that start is not a wall
        if mazeAr[0][0] != .empty {
            return false
        }
        
        func fillElement(_ x: Int, _ y: Int) {
            mazeAr[y][x] = .filled
            if x > 0 && mazeAr[y][x - 1] == .empty {
                fillElement(x - 1, y)
            }
            if x < N-1 && mazeAr[y][x+1] == .empty {
                fillElement(x+1, y)
            }
            if y > 0 && mazeAr[y - 1][x] == .empty {
                fillElement(x, y - 1)
            }
            if y < N-1 && mazeAr[y+1][x] == .empty {
                fillElement(x, y + 1)
            }
        }
        
        // fill reachability
        fillElement(0, 0)
        
        return mazeAr[N-1][N-1] == .filled
    }
}
